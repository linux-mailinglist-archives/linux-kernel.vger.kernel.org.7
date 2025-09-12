Return-Path: <linux-kernel+bounces-813939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF16BB54D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E9216C758
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDF2329F1F;
	Fri, 12 Sep 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCDjMeL9"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A7324B3B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678937; cv=none; b=CqlyloBpEZXOObA7uSKmpTrj/pPvMakZT1CEHO7Nv1hQIHZFdRZOjKcxSSxksDNWIeprYxopicsll/9WqNpcieclnpmlYV6Htf1vZhCH6P837a4XI8WEsab87hdoVV54yYGRtBiwXpFAwCj6K8fnr+JgOXZvwZe9K1Oi9IwPX0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678937; c=relaxed/simple;
	bh=I2XBnZVyAQMrhhSI/DaBzgxF6FwG3l7nrVJBzdS3kY0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=SwRHak8JhH5AXasvhJvfNbJZpnA1p/S4eXvQtela0AtZ3LCu6yQJh/QwtGD1B/NJytAbCw1SQChwbDNBb8x94jIP9DJdAvZFhDCTx9dhcTT5PMQFfSlH/AXEHrw1rV1aty9cCekBIWKGZXiIrDigZSLyDvtIWcG6344vnEsRpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCDjMeL9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3df35a67434so1174608f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678934; x=1758283734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I2XBnZVyAQMrhhSI/DaBzgxF6FwG3l7nrVJBzdS3kY0=;
        b=RCDjMeL9i8K1JbbO2eI/BdU5hA2tdYuXIlaaxoOspmTMWYZnJa7t+8jcLYJZVCP3Sk
         3WLtjih0uq1RbNCV42meTejOoR5e2F0s2cREUK63BadUSiCQgrKF0uI207d0e9hZPBmv
         82JdHECXqdAXSVkdl0eF7xhW52irQwXJ1JH8Ravin82p1DnnIJ11EGL3Cm7y9D3VjcTX
         zacxVL8HZtnX7TevBCv8eA8W95BSJwfCDwmUZQ9ZYgfSP54r2p2pDxc3PHuSr/7OtRrC
         fLjR4XL46dUsCr+2L/jh4laGAft7PfPEhcMqBL6Vsra+3+wAlY23QIO1Xoc1AbAzYznz
         XqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678934; x=1758283734;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I2XBnZVyAQMrhhSI/DaBzgxF6FwG3l7nrVJBzdS3kY0=;
        b=WC8GCpE2NwHI71jSpxnvU2KDRHNd7N8Pe7G5RyDXHzms0hA4DRGWX6Y5W50/1bvrtZ
         FLwVo1eEZXGYE7SMf/6QYjMN2dw58UTEedcb7tWAlTGVuijWjsS2WQv0HFsbm/mLm7LI
         x4n8KCevEpofusf/6aQaSigR2pHbgUV3R+xSOloXBTrkazlZX1lXkuceIrpTbST/l2qR
         taop+QBVln5RSfnAPSk1TsHU6ea57iRS+1C6Fktfe0JNXyYKndnLM2IyJFb0PLe2nyqf
         +72iEd4lDddKR2eJhsYOFXu/t7CmYMd3Gu2VWYzyXLhLEkkwcqneFDLQhKpm0NCpbvW+
         Xu6g==
X-Forwarded-Encrypted: i=1; AJvYcCVs+MCLo4X1WJo3Za01q3y4hOkdDWECgF65P0PBclHXq3+tWMKDGVLZUNRPO7mMiOhFUnOKkk7zoSKMwa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycjcqy2tk2t/a9Xl1KPhhHWjN7oLam3W88Ka5HCQvqRUwtInXp
	T0qWCTiG3rkUVGnIsN2UEqqTP91gA4O6zF3B/ExTEMNbDcw3sZcEjfvhdwxoPQ==
X-Gm-Gg: ASbGncstLhiVtBbkjxzsPeKNhWekXdeb04WZI07fnZuV0vXeqpN9wh+RixTXNutM7j5
	b5m6NKTNBoq+G7yQ8XjB4lkCwVzHV7jxANpD48naFsemgqC8hHSx09QCNOEThHGJzxlmTx3dMIk
	woCwJDJNF9zFsqF7TTL6pQb5qZTKB5t2Vr+2SVp0mlLT62sG+mRHjFWeq6dxzTXSE45lDqiVNiv
	1M+EOMxr457s6H7rE7JA/4f5d2sKoo8EKInWTqEOEN/SGF8HyyG1uNxcGej4/fFSvYJiAki2uPu
	1nEABBn2BEcNO2AP2u+Gg6bpeCWA/mZCGbVAOVmWh1ncFEZYdvPXgm0u5WDfj5moBNHnBN7vd5S
	uqTsEAMlyKyZHoJrz7eAd3joG+EUwL0+jtw==
X-Google-Smtp-Source: AGHT+IFHvsX4+WM6Fj66Yc3KV7zMbPnHeT1OHPDmR/usCdny9EBxn21UZKnW27EJ5m4ay8CYAoEFMg==
X-Received: by 2002:a05:6000:18a6:b0:3e7:486b:45cb with SMTP id ffacd0b85a97d-3e765594133mr2411503f8f.3.1757678933645;
        Fri, 12 Sep 2025 05:08:53 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0157d68esm32967665e9.6.2025.09.12.05.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 09/13] tools: ynl-gen: rename TypeArrayNest
 to TypeIndexedArray
In-Reply-To: <20250911200508.79341-10-ast@fiberby.net>
Date: Fri, 12 Sep 2025 13:00:54 +0100
Message-ID: <m2wm63ubgp.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-10-ast@fiberby.net>
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

> Since TypeArrayNest can now be used with many other sub-types
> than nest, then rename it to TypeIndexedArray, to reduce
> confusion.
>
> This patch continues the rename, that was started in commit
> aa6485d813ad ("ynl: rename array-nest to indexed-array"),
> when the YNL type was renamed.
>
> In order to get rid of all references to the old naming,
> within ynl, then renaming some variables in _multi_parse().
>
> This is a trivial patch with no behavioural changes intended.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

