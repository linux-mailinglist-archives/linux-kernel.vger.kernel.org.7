Return-Path: <linux-kernel+bounces-899054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1590C56A61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 247784E7C09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A153271F1;
	Thu, 13 Nov 2025 09:36:53 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4830AAB4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026612; cv=none; b=OD4jk5V5NUW8f/sEBl3mMhePspwIuapERUHDOl0F+RHkapMkOQ/dY+86ROJ+p87Q0m1GObOf479Hr2ymgzE6qtclCY7rWy8xwb2h08aX7iBsJA80BbTphJ3Hw4egSIT8DCNNiciy1CNyCJDfvFCwqkWTwayXs4Jxd5xAeQRuqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026612; c=relaxed/simple;
	bh=B1IQPBIKdLkOKPrLDwx+jpTJ2s8a6iErLKRgTx1oNmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSSLAr69Ye+CVOXG6DOyDdVbaZ6AipyVmFJQYpHmT/UYRYdS0dsQm73ZFI+744elVepfZuy+wucOMhcZpPjKCMhVPHKSmd9beLhh+OVxVdOsjhyOIpO0FS/kz1kswIohAuPe0Fg5Fo+BTTMtJIGt12hlAcY3B+loZukNdSE+zag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-656b8900ac1so368182eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026610; x=1763631410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afqFtStE7aqTe8kA6SQYmpVLf0qH3d4gh7yVgn6NgSk=;
        b=OzfKQwUS6fqCNGrWp7UQT0IhU9LJL0B50YmL1jhxo48SeAviIcT0T0R3V9VdcfZs7+
         F/pICErU8KacYFmAc19eHpGJmDSxxlzwYAckJqR8kNjPpe5HEUv9Lqr35CxsBM11RxZL
         WdqUUGHCsYgV6BgCP0Uxf4aNO939J3AMHN77CtwS1rjc14nRoByY1D659gW9wElzuwZM
         mDtUNjrKVoIo/ehu0FvzEnPKTUvCrGvfOstWxkBtUu62xPy5tf5fMfkUQoNu/EW4LecH
         ZWQjCVYxrWyrh9xdQQiuw9HM1FGIYAJgo9oUVqp7ymDI7U8+z7lOzB8kB6T5DcUeJDaT
         04sw==
X-Forwarded-Encrypted: i=1; AJvYcCXq4HRcEpUYmZiAhLO8w6wImjR0/4L8k0UoI+9R10FN0iRpVLWDe1hBR1gT9HJuAad4UDlsPmq9n8fQKxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKDKxmfv3OoXvH5idBOOCvFWi4Cesq+b9WYEPwGuDiHE/vuaX
	uwgthXu6grJDSqVz9oou9wWhV3V1fZ4J0A+MmqSuD08gg2bq8I1yHvEG
X-Gm-Gg: ASbGnctU44SFjMWg4VL9mWtEyeHKVxxuIauoLj2j+Kj092mSRVesPQLdTY5U28tUG3P
	KFZ5uYacZ1dumgyHJxfQSmlksSgNpqlaOfDaQEJFe8ahJse5J4UIrYkYuZeq9EAyevsNG3LzQGK
	rLOLsUFphWOx46U9PKEYVNLFfbh+BTSQRhXneZd283I6CcGstjY557fgfltd+dGn3IevrpWIn4w
	JIDB0b7pzt3yufNrWuAT/2Fq1szx+g7j5bctMhZHUF0v02nsPh6baD9hjCHKz+QhPPFRnbcFeuy
	PZ8MEK9mcDnj8hQMergnZn16vJHSAqKqvx5fXckSX9fBdBnnkThoZ/nGVkd2fdCBZK0N1gjEBzb
	eOODFwZ1/Qgrix4We/UW71B0B4JWEli+X595FnWF9lAHCsUhPGz0P2HU5qxHo9Xve7OIEVXejw+
	/uqJE=
X-Google-Smtp-Source: AGHT+IGNwD3jOzyauRl7M1I2AVm7S4d0kstCdP90+Hgk3itBXkuD/m5+f3uEr9Ung4X9GPewFShbIw==
X-Received: by 2002:a05:6808:190d:b0:43b:252e:f793 with SMTP id 5614622812f47-450745f0ee9mr2565488b6e.36.1763026610516;
        Thu, 13 Nov 2025 01:36:50 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e85230b2bdsm1038362fac.24.2025.11.13.01.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:36:50 -0800 (PST)
Date: Thu, 13 Nov 2025 01:36:48 -0800
From: Breno Leitao <leitao@debian.org>
To: Marc Zyngier <maz@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	paulmck@kernel.org, mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: arm64: pseudo NMI bootconfig question
Message-ID: <sf4iq6uyq64lbrrggwssq2hxslk2qyetm3owplw5rwzqgnemrn@o4beszh5aewh>
References: <rs4igmsjrm6r2aio4nbe5jos3vcqk2u4bjhltjwtj2pn3cquip@kv3grgec7qrb>
 <86v7jftjq5.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86v7jftjq5.wl-maz@kernel.org>

Helo Marc,

On Wed, Nov 12, 2025 at 02:21:22PM +0000, Marc Zyngier wrote:
> On Wed, 12 Nov 2025 14:05:43 +0000,
> Breno Leitao <leitao@debian.org> wrote:
...
> > Question:
> > 
> > Would it make sense to provide an option to enable pseudo NMI in certain
> > kernel configuration without requiring an extra command-line parameter?
> 
> [I wasn't asked, but I'll give my answer anyway]
> 
> The short answer is no. The long answer is that there is so much
> broken HW out there that dies a painful death when enabling pseudo-NMI
> that is isn't practical to do so.

That’s helpful to know. I hadn’t realized there were potential issues
with hardware implementation, which explains why it isn’t
straightforward to enable. Thanks for the additional context.

> It also brings a measurable overhead to some of the most frequent
> operations (interrupt masking).

For debug kernel variants, performance overhead isn’t a concern since
they’re only used in debugging scenarios—not in production. So, it’s
fine if things run slower when the debug configuration is active, at
least from my perspective.

Thanks for jumping in!
--breno

