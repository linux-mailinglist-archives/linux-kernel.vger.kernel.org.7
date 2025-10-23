Return-Path: <linux-kernel+bounces-867583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3152EC03082
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751143AB92B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5391727E7F0;
	Thu, 23 Oct 2025 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="cHT93CGn"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723A2327A3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244735; cv=none; b=mO3vDYq8QDb+2rT1jsWncBSHMXg4BltIwodqxAL3T/hchUyovS3tXuVY2VGj2W49H2b80Vvv0ulmoTZ1rUkN/Dy6bPYn1OJ8kYBCscG4onkZ6W83A0byZTZWbGL4xTvSHk3LghekZKwYNXN7zbQA2i5BMXS2TIDuk8DAxiBVkV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244735; c=relaxed/simple;
	bh=IJz322Dk2EbU9jOBpCOHtD/vjWDkx0Y4Ic75icLEf7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfdsap42gqxKa5Ef7MVdjg0d+FyNSsreZyQ7u0A0npJdXAEjiOnYImSDRDOaQG2kf41gNNzX1Zy3Aq9CfyZ+NhveG5YQNnohL7tiQJGc9KF5zFrSX0bwKW8XI98VRkesT0/tD3tGvB9/PZNQjXxa9x8jFyM5y1lcTWYxPdiSgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=cHT93CGn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a28226dd13so256973b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1761244733; x=1761849533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJz322Dk2EbU9jOBpCOHtD/vjWDkx0Y4Ic75icLEf7s=;
        b=cHT93CGniYOkAK5Zk/I6FxHqgr8b1cCatB7WB8/ruwecUfO8CMsd4t9mdHxGlM3/oq
         lmsRz9jYCn31HY/qeBqwqf/fF6IHhlJTFmZMwQLuyMHIh58+fEnFIWsIB4U22xMimSyh
         ykEt4IWfXZC93j2NMTsL0abj6FNxw/5EBHw+YzniLdwMUfjAiFy18AfBlrXlat8/SWks
         l3v5foR0x3ekjxeCHGp2XTdGgk2IgWrCtsp7kmx7fDSBC9kqDpTaiALlt+0vbJNliCKm
         U9CjQsYeozGTiUfkwF7Fz49GZM0QHnTPPV1fwL7ZeAMyKM/VP9x+Iw0S+ZW9dZmwW6XQ
         HCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244733; x=1761849533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJz322Dk2EbU9jOBpCOHtD/vjWDkx0Y4Ic75icLEf7s=;
        b=xEMSA1aRk2kX93DJ8uu5nR74kjO1TDXPzHyi9YbDJCJoG6WWnB+c4GBh/fSLb+hjG5
         L5YGMdBov/PQqFfG+Bif1oLTeOybRtBHqo6T4DazR93YxN07g8N7ZVIN9ZnWjvnb2KTH
         LHTXtOMKmg881Qo9f/Pw/WKpc+z7W5BeN7p3FGV17sOKZ0qbLqAvpeMoqBIMYo2bX661
         +jo6dve5xv1teghUvdGRcNUMnKeTFAXyGY0ow7CarXGuqhI1pKLBBnBtHloT7Uywa9rn
         kDo6tkGvzKxGCJjus5JXFeoV6uSWxPS7PXnrLfYcv2cVSpitVRed5RwnHw/A7o2pJusi
         JXDg==
X-Forwarded-Encrypted: i=1; AJvYcCUIKhOZCpBy06sCvCh56DB6tPZc3RmwOCbBoG6vE0dEje7wXu8xxnqaWSYbsQjLQGw5W3A49A556YTZIqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4znUoKE4IJedLQpIAQcgyIgVptfdiXfLXTWE7hTyvPvQsGemq
	5OUbbgpiwOOJlDb3MHPesx+BgVoiB+epFPy3OVWExuxnjBYmQD1+CK4xORH2oEk2ao0=
X-Gm-Gg: ASbGncu6qtRj/1rLNFlV85k2xxwaYwvE0kb/AnP0KuiMZL+Q/z4EHC5cdG0aedJGfeb
	icWVY1juk9H013LUl6XZpZ66e/AiYGP3nH4ksubiydjyMZsr9FXo4RKdQ17lvz1DMUCLapcUqcy
	VUKmo2UGnTdGIO7ihVhTasvuuN7kFB33bpIPzcL7S0K7WrGMTF26kNjCe95sz0yQdsCsmFEYGGM
	j/2uBoor9YwV/NJOeUfpwZUJyX5/L6Z6pCApHxQ45SJHf+Y7sM6Urb1a+/to2XICO6LnV/RkyrP
	PYbvOWvRzHInoSRLH4FbBs9O2hmInWXRNy/E9/wHBYKAVep2Gf09bYnXgPLcDfnFn3aAa++kXiO
	bZdKlVDnLzJRWZT7+zhOI8eCBm+IMm31p+Jtar8Q9BsiySvn62UT6bxeFK2RVADxL8lVncktdOd
	w1Jlo5TR9f3y2j
X-Google-Smtp-Source: AGHT+IHv4EEmGzJ6qdnkG0U4M/t1i0Oxb27fs6YPyYXb02bVmUpsxYKcjyZyI1rde0buij6ZTIgCWA==
X-Received: by 2002:a17:903:1a4c:b0:267:ba92:4d19 with SMTP id d9443c01a7336-290c99a8ed3mr313633845ad.0.1761244733473;
        Thu, 23 Oct 2025 11:38:53 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de105b1sm30862925ad.49.2025.10.23.11.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:38:53 -0700 (PDT)
Date: Thu, 23 Oct 2025 11:38:51 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Francesco Valla <francesco@valla.it>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Erratic behavior in btnxpuart on v6.18-rc2 - and a
 possible solution
Message-ID: <aPp2O-H55h4IJOFU@mozart.vkv.me>
References: <6837167.ZASKD2KPVS@fedora.fritz.box>
 <2569250.XAFRqVoOGU@fedora.fritz.box>
 <aPkCZ8l4-5ffyiAe@mozart.vkv.me>
 <1982590.7Z3S40VBb9@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1982590.7Z3S40VBb9@fedora.fritz.box>

On Wednesday 10/22 at 22:35 +0200, Francesco Valla wrote:
> On Wednesday, 22 October 2025 at 18:12:23 Calvin Owens <calvin@wbinvd.org> wrote:
> > <snip>
>
> I tested this on my i.MX93 FRDM and I confirm it's working. Can't say that I
> like it, but...

Yeah, on second thought I agree, the cross-driver dependency on drvdata
is gross. But I think I found a better way, I'll send a patch in a sec.

Thanks again for looking into this.

