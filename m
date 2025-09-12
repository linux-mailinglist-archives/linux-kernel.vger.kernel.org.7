Return-Path: <linux-kernel+bounces-813941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAF1B54D17
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7746B7B22A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D0630505B;
	Fri, 12 Sep 2025 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm5p63t2"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075D309DDB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678940; cv=none; b=i2FDNQ4xWba7iwEuVNeKaMq5z2rD81T+pzTNzlgQ1Opi4sbWrIj9pqUbhfgLV3jIfwHS6rpbsvd41EeYPa59hoWllVPGk45V6dUYTTpx3Jwl24dJQ5SMLxLLDjJXBx5ExxEknMvesA4Gn7iwnCauOwb2aGOi9avlhAC55uEopR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678940; c=relaxed/simple;
	bh=ZsDPHM1ssWGkUCApaTOQGhUhKwRqfUFyjo5Rw+9gVd0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=SSyQO7JkFXj35diOgN7hX2MOikP2F1Wv/klRZECjeHbYJejVg39JTEyTdQDOjkGDDwWp41CkndougOaBDL64sGxToQdbZTk51tbCQSvQo6VkYeWQuLHcOxF8XaEleb8dyy0MW5MJWq86+gkADz1pXdVYUglGdbbt0P5rhZ5XHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm5p63t2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de287cc11so16067785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678937; x=1758283737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AuxBhXYIf5asuisWxd1fF0vikMlauZb1ySpXLM4BDYU=;
        b=Fm5p63t2PJ4ezHqOdrc9AaEaiCNRZdhPRzWPS3ZN8o90x0YV9a+ASscXHBVI4aB19+
         cwKXlD7MuvcuWBG9CW0Q4GO+3LxBbhnDkM5h6lOXJ9YUkJe9SFkHLdO/d8RYbWCIYLra
         1iJPNmq3wQfc4KI7mLUeYbODfmXfTiJ4NnqI4a0pdtISllwA4V1zHJsneiNLBUuugICl
         KSWsjZNDyBPU9EPofr8Wyll3tFROnMy7MBedLAS0LiuSV6245z0MwAz0xXdHLtT172gK
         dKeOWGdFImuvjxlCDdYwLFBzI9Ad614hY+m0RNqvbjbeqS4lxoyvp4uBIIK4BVz+WV6j
         gpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678937; x=1758283737;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuxBhXYIf5asuisWxd1fF0vikMlauZb1ySpXLM4BDYU=;
        b=D025AzIKd8mqJPCNmunOuA2A3PmiWjQskQneXa+3YlSORthyEdCho0QQYVIt2oE/4H
         XVUff4Y7x+5INI/T4JRrV9yi0zx92F1ae7VGTLFxGrmNT0HZp1Wta5/9h/rnwa26xae7
         /woshsq6iJZqLLkwqn85MOtLuNYwGjpzzt0f591Y3E/PkRkOqoRgZDhqKXTGzrPdiRfl
         2/irBfGm1Yj9wmOjYt60NgRqe/LiahK2Eu3iUtHCHKZW2emJTczoeBBvth/e7cEEBr7J
         JvFSoaiBIkWf98RHtHYzCxllJlTxHEr/8YjHS4rv/Rf4Vx/4cnkbiz3nugiXxhKtaQXZ
         3EZg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Gqz9P3Pf2/0nuBhgwjugpFHYQdML5LbfbrcuC/UHoXipJvg0JuViPVd3pUVx5GQq67BnFpbNvXmuWLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzd4fE98HL6q1sMUyiU5c4nHqaZJuv9yH+bzgc1kDblxIrXGrY
	bkMCHswKyp6z81Fl/WGRjbE30lMDBLRhxT51agquGQmLdS1SqPkwKtUZXWDOwg==
X-Gm-Gg: ASbGncuWFheBenOLHRp6H/BfoU9jsqEhALVMrhQ1Yqsmul4giBaBX8JJ/hPQ9q9Vtom
	KDotJuWv2u9yEmkL8EHvkvewcprDlnuPPAs4ReEZEsoAYFwH5rbzl7oEViyqEo7PPZGwcbSKTXB
	CStBgP/6AWJg2LCWMsy7bIo6JdToho0UqUOBv3wLpmvayJnKiMmFpr+4jotXhj93NL/sK/nHB0V
	fK4ryPMq3bl+np2qTti/kGKZGbpOd5T5hON56NqJ3G7NggDzw9AUKa1rQh+j3MEouURH14FWKtt
	MqGsrIac/EXtbxbOqUdWj9CS8e4f/3Y/dSckxhsV0biT53uCHK1XTa7TVK6BVY/aF5SWmIQMgdT
	9+z6+kcI5dNolYRDMRDXG391/g/lMPhBy5g==
X-Google-Smtp-Source: AGHT+IHXNEYZ8zt4iDcGj+Ej24DzoTie67SzfFJOypYfKefxWkzvz2zcFJy+fpJUKaaXWFGXQhh7ow==
X-Received: by 2002:a5d:64e6:0:b0:3d3:6525:e320 with SMTP id ffacd0b85a97d-3e765a23893mr2442300f8f.29.1757678936577;
        Fri, 12 Sep 2025 05:08:56 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7d369ea3bsm616186f8f.0.2025.09.12.05.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:56 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 12/13] tools: ynl: decode hex input
In-Reply-To: <20250911200508.79341-13-ast@fiberby.net>
Date: Fri, 12 Sep 2025 13:01:48 +0100
Message-ID: <m2o6rfubf7.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-13-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> This patch adds support for decoding hex input, so
> that binary attributes can be read through --json.
>
> Example (using future wireguard.yaml):
>  $ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
>    --do set-device --json '{"ifindex":3,
>      "private-key":"2a ae 6c 35 c9 4f cf <... to 32 bytes>"}'
>
> In order to somewhat mirror what is done in _formatted_string(),
> then for non-binary attributes attempt to convert it to an int.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

