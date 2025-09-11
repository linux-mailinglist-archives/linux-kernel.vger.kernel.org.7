Return-Path: <linux-kernel+bounces-811915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0232AB53009
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2961885704
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556A231355A;
	Thu, 11 Sep 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+zX5U1K"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCB313E36
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589658; cv=none; b=BxEDLBTfovtzxOnDqBX3CuBPabb5zDBbZ8DLbB80PdW87i/ndmDyLgZDl5qRbIVD4qig00O0BFDjfOEklymapmQT/zwOZHNOmFOe3t0ZfbYVsfLUM4+kvlq8AGVxUUbFwkYMNBnIvbuEzPCe+u+LouUYxM8FdZOoHaTrC4Aq0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589658; c=relaxed/simple;
	bh=zy8valPOq+5TQChc2jB5gUQh6GVTf0ilWXpF+hPVga0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Hdr5APMy78yT7QJnjwe+gHc5QBm0hgzW9ZmW5BHhPkUysQhct0Q5CZGWpifxVSLMdLiknw7eZH0gVmn6ssOgQN80vQLEW398KmHZ9s/ykkU16rzYjP4NMnqNOjexLc157EviOD2HhzBndkLrGFmGhYeeEiqi/d9t4qSXiqVC80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+zX5U1K; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45df7cb7f6bso2562595e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757589654; x=1758194454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zy8valPOq+5TQChc2jB5gUQh6GVTf0ilWXpF+hPVga0=;
        b=K+zX5U1KngGe5lvACq36N3zgKcZflCr4oGrB+gZ5pTqB724h6gz3VPw7pdV4OydC9D
         ThJMSMAea3XLc0S+Hrr02mcltGV7koW9VzzxIrF0gfiWuRUjWx6XvcNY2Yfqp4d960Ka
         Vofe1gnMkKYwNV+NgYzVxw3WIEXfUTG5QuVuG3ARDKbRaExVZJH+lGP08qnX2wrwHxB6
         fbyxEtBNpskotvt97g8Jwh5vUA6gQFDLsXze7vwaKEJLnZ4nGUVtp2i8i0pZWCCuA7t2
         SSEs4niG3s0Rrzddzsk3a7iLAqcz/n9l+8KbfODf9NX6bvDNd7WylP0LHPqL9epP73+P
         k8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589654; x=1758194454;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zy8valPOq+5TQChc2jB5gUQh6GVTf0ilWXpF+hPVga0=;
        b=U/n3UoVpbnAku2zl/5ZM6h4fvyahpPbGDYYhSxtPn+WoKBnds/SSqWvUMt+ze08vuZ
         56DQv9xKOMasJnRUsV+Ht1XszX02dcNF9fYLZN82u6QJc1Nu7iWTkRfVOM0An7Dtop0H
         vPH/3kwVhUl7TtY0jqf1+ybRCD6TCNueFWOmH7jm5UoACwE5slXcS45G2KdKscYmXzrU
         oQ6cDekxrY1fqJ9nXOFyOSImgrWuI1hJsUJIy536sv1dSrUK5azDwCSkhxVyobFGEeyD
         bPV093NR97y5s0YcTMFl4nchnZCBQe/u0ZQGDnnpnShxXv7Cp69jfohsmW7Eh7+omQ58
         Ojtg==
X-Forwarded-Encrypted: i=1; AJvYcCURb3UiOokZzUvhUfjgOrYaqWphWTlj9yyiKDAFbrsKfYDTR038vOYeDcjImXUms1OnyMTVupOU5h3kI7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKebelB1TEaUksvnxCQ3DakEWm9UcMlUhGa6tDEdc8hgRAeyB6
	Bd2xmfI/wwTwClerd7hqDfbnLqLMNd20VkSEWrUHNbC36C8daogh9CXdCIU3pw==
X-Gm-Gg: ASbGnctUxAirvd77KXYdinQrYHD/J9wXTJDnsiRoG9SjZinJbdXro4QWX6R9Rh4s2Rp
	fW4w8qXtf0yVFBTaZYdPe9jXpin+OrsLDwUkapjX/8boi+Ctb83TBYC3MuPso+TNKPhpsxpp/7i
	wxDYZvsbg7k1N4LYCEVfmWTsCDAeS9wWukkT8gbEHxfp8Rdm39+6ALPQbOtFlpp1LroebJ+BlhN
	mtbDWBajTfKfteFOsRIUVTnRxB9HM2jqlXywjISTBaIcvgwpMcXAGH+aEBIut6qJrFJ227fTD27
	K8b2SpFs1Oidm/4XNLHqd95yON6Yo9hz8+fH8YM0ZQ/fileCYG6IQPhsEqCM5KzhVyylM3pTRNA
	5hs328f5iWbPJQFjEOz3eED2pDo0zoK1yBd7KpfrwQZlCB02wfrGLgkv2wREQ
X-Google-Smtp-Source: AGHT+IHPRyXDCKOm7qQhOay8cSvONkh1hTjaOIcriGGovjXk8SONeiWwYo/6tBJ9G+d2GC5W46uqTA==
X-Received: by 2002:a05:600c:1390:b0:45d:da7c:b36 with SMTP id 5b1f17b1804b1-45ddded7614mr164680975e9.19.1757589653499;
        Thu, 11 Sep 2025 04:20:53 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c3ee8sm20447335e9.18.2025.09.11.04.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:20:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  Sabrina Dubroca
 <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 05/12] tools: ynl-gen: add
 CodeWriter.p_lines() helper
In-Reply-To: <20250910230841.384545-6-ast@fiberby.net>
Date: Thu, 11 Sep 2025 11:47:10 +0100
Message-ID: <m2qzwduuz5.fsf@gmail.com>
References: <20250910230841.384545-1-ast@fiberby.net>
	<20250910230841.384545-6-ast@fiberby.net>
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

> Add a helper for writing an array of lines, and convert
> all the existing loops doing that, to use the new helper.
>
> This is a trivial patch with no behavioural changes intended,
> there are no changes to the generated code.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

