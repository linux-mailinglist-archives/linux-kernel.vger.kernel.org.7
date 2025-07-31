Return-Path: <linux-kernel+bounces-752369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E321B174B3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764F917A8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7527E23ABB4;
	Thu, 31 Jul 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6UM2Bzt"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36423A9AB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977940; cv=none; b=cvjJgS70x5IAcNUWL+8c/EBKgefes33I4/gWSP/52yq1m7pPB+qC098YZosO/+nh/F4qKzDadEsvsTmYINOEdatuEOnpe2HjYXQSMRx8PvvPQmy8AgQCVzCwq2k/QXA7H2AW73QDbHlQtaEoLGASJILJJNoAjUasBx246aa40Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977940; c=relaxed/simple;
	bh=CnYIEKLx4TAFUxdZTssELh7lELrZ7WzEgh5Jw6CgJNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9qkadDAAXEQWgnipop0Z/KakFJHmRy7w3mEsFEs+cCGenI8psel40v5FqRl7IB3irXPR3nnoYvYnKbUGozJMwu016cxQiIYkIN6wqJBoBdqxXLtdGKVYIlpM9AP29+VZ+Q3Ai+6LXsQhy2hqgkwu4c9Px3vQTSl1/kWL4dtPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G6UM2Bzt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so735139f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753977937; x=1754582737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LdhQmFbMkNSed960dmFtejqXjsu13SQnTKg6pcVU8yI=;
        b=G6UM2Bzt9DT7vB+ewp0JItcA4IgJj3DjfJT0X+V1WJGnxcqgFNgZxL/zkmUAvCgg8e
         FEbVMcrHGGGZwG7rrVUtsfPSa5xUUPDJqd7YBMBv8fHB115izTXzO1bc6KwjYA3w5kAd
         pOFVvnZSnXlCnv8MDsd/2jPxhH8HBvYR0KkOmfPXKWxtOCFii6En1FqIryGK2/4lBptJ
         IblsNZpsT/8dxMGrJnLFl3ZYRrMpOkvVOesf2QPcRdskfCsRyP3ovchI6lJRFfDTAySX
         slnK2X7EsZeOMfqElJdHWAqR23jMspesgo0/+HekoRpcDdiI5iKe3o2BRhMTpbtSYXuW
         9r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753977937; x=1754582737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdhQmFbMkNSed960dmFtejqXjsu13SQnTKg6pcVU8yI=;
        b=LbiQoTv1FTIX9t+V79j4eQ46ru1H4ZFQqAkY21NdiuEbbrcMB2DijXjkANnwecv9R8
         k4bB+RmKBcRaByrN+UBhC1KbFVNfOAbC5zYuC5A2onX3YK7gZhKALtQCfoIapJp3y/Gl
         nebw+yzEyRskhbMbStvtLPkP2CwYuKubaMpmTn2yl4RzCv/OAABUk11uL0BqpnUTNI/M
         jmpPATnQ2ry6JnvCF7jzK38UWpPgJtAsJpIPSC8dDLO/yWC+kdZauao4+4U3z6pbbsDr
         1NvBSPvJekQx6Up1w8HBypOFIe6xUu3xcFlxWHvNn6BnN3V2yqWlwvCcoY6i+r4+AZEx
         96mw==
X-Forwarded-Encrypted: i=1; AJvYcCVV1Bt+SshxhJ36bSE2R5nCQUynRNIuT3HaOX1D+XfRG9TouUGUMG2wb285JcQL1vbcS6ZTqEuot9ZdV9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoa+X3eKqmSaVaBG4UkbSEhrqaiiSsvo4GS0W+tH9xcO7+0ryV
	3Tg9O3jD/LOHGLJ7gAIZfztTmiwtM2EEWD57zPRBjcDmlTOGTPY6GlO7IYF4S+5bYQE=
X-Gm-Gg: ASbGncuB/0aOn57dMZmnQlk6XiH5iiQlBUb/8RxhLlI0rNaGD+aV5425qIn0DCSxrqy
	JKgadWzk4C+WecbQvC8Jv0NYZDmHSq67gc7rk7offlzkbfHoR/BVkXNuNv8zKab2X7N/hljwVOm
	tM9+gShmxNdSQWN7HFl61RlqC4EwI4n/LhxJZtckztCwm7wJqzpR6mEeEEy/cU2LzZgBVZ1fnMD
	ZM1+6G1mjbNW5dvPUVbQxmdrEMcEqyiHho0hCHSL+7MGtajg2FkCqJUH69y+6gOI9EQxyFXxVfu
	dyWeBjKuxiSfz+YjKNB9rKuWU/b63a1YczKyh/0zP23tkSgEEwpHZ0PMUVmXyZsCKgzaEmtIuyh
	0ChG09K5V4Q2x9sh4lsCgucf45/zgGt9bFWsQfura0qE=
X-Google-Smtp-Source: AGHT+IHKEgPI16zTrpdtBA345eAj3eoJCpdLSHZI7HH7keABCX5N2v7AOToBccj7RD32n4zicM10sg==
X-Received: by 2002:a05:6000:4212:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3b794fc182dmr7100030f8f.25.1753977937312;
        Thu, 31 Jul 2025 09:05:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45895377956sm69939275e9.10.2025.07.31.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:05:36 -0700 (PDT)
Date: Thu, 31 Jul 2025 19:05:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ashirvadm04@gmail.com
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	sayyad.abid16@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Replace magic numbers in
 rtl8723b_InitBeaconParameters
Message-ID: <8c350c13-3e6d-45cf-b9d2-2e8df07b6dd2@suswa.mountain>
References: <20250729141224.16013-1-ashirvadm04@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729141224.16013-1-ashirvadm04@gmail.com>

On Tue, Jul 29, 2025 at 07:42:10PM +0530, ashirvadm04@gmail.com wrote:
> From: Ashirvad Mohanty <ashirvadm04@gmail.com>
> 
> Replace magic numbers 0x6404 and 0x660F in rtl8723b_InitBeaconParameters
> with macros TBTT_PROHIBIT_TIME_8723B and BCN_AIFS_CFG_8723B, respectively,
> defined in rtl8723b_hal.h.

I don't really think these names add any information.  The number is
related to TIME but no one really knows how it works.  Someone posted
a theory about it, but it turned out that was just AI hallucination.
The spec they quoted was real but the sub section was fake.

The 8723B is the name of the driver, but without the "s" for some
reason.  It's just words but with no meaning.  It's a map to nowhere.
It's a waste of time.  I would say that there is also an element where
these names are a bit misleading because the BCN_AIFS_CFG_8723B is
really specific and the name suggests it's more of a generally config
button.

Just leave it as-is.  I would suggest that you could delete the TODO,
but it's good practice to just learn to accept that we can't fix
everything.

regards,
dan carpenter



