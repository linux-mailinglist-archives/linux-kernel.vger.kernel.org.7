Return-Path: <linux-kernel+bounces-794749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD995B3E6C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3856F1A81251
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF29340D91;
	Mon,  1 Sep 2025 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHa/1mT2"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638642EF643
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735938; cv=none; b=FDR3bqYfHaz+/bwTUKf8NkF5qc1pRcHsF+lHfbRRp5ApjO165KPzJKjxIqnkpJ7O5mUIHNPxRbryR36aCeS/nWOEqDeMgUrRGv7xub9BN2DQ/ibWvvWRAak5Chj8zomHaK18mEgTC99uAS/WntDrZHpRG6kJiibH9LLqpT1gp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735938; c=relaxed/simple;
	bh=VFHLkcEeg+u4xBDxYcPzrVS5Fy+xtArUMIPnlQSt8Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXw4UuTm5OrfWK1CEhO7149CMhLxs1HkrzOHZgyE2sBWrG/lpByw4lKGTwAq44hlgy6gLjEkF8RORuvltvi9t3j3T9yZCttHK1lvlCES0wkO9WAPe3xEtYrJUG9+bkTGVagtIJ8tgazAwXYpBJ3Zg5kkPski9CzjYRUBtSIHh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHa/1mT2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b3319c3a27so7408761cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756735935; x=1757340735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypREcLEKQuyuV78ZOZQX5xuyP6sjl5/wVdGdfGcQlPQ=;
        b=aHa/1mT2Y37Jbcym63eV7ueXd9yT5Jt16Ep2+jVS/r7JSzhWkfYGgkR89B/1dLgkHj
         fHuT7UbYvhjML8qB8nQdjIkMkmTN2cTjT+fID5xHeokdU8mT8ANYIOm5PvkuAsg14MzJ
         Qv0+3e8AwSiulFxrZvz4BQtsIJ6889qKrZciox/pP/lHre4dhD/kUfOXUHlQrvRJOjMu
         DujvA+OkmlV+FN3RmYpWseKX4QT2Nnw1kqzAtEnNi+m1yOw8nCUpBEn7eXK1anK4zv42
         6XSUis3jxlT4g/8xyqqqfCMHSzZ0fqOYAa++joU/Qp2C3Rcqn4pLFqaox0bx+L5VGeoH
         l0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735935; x=1757340735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypREcLEKQuyuV78ZOZQX5xuyP6sjl5/wVdGdfGcQlPQ=;
        b=f5EnYpdCXuakseoeSuixy8OEwz24VvQO2GARMMqutrkBVg8LtjDkJId5iREGVeuZUy
         Eq//LI08mjyPN358zgLdALR2hpkNlps+L+g7OcTHEeZDWLbXFsRku9S42wNBc106H4x4
         yVVz7cK9jCVEudQuFGCEgZIAlMsMHR/gkfoABnFGUC7TMip/wDJQwvXjRb36Dddifa8r
         H95MyPg2Cnjyqbx53tm6ys4Lf3ECIXxBxzTHva9235vtK2nBBdmN68/vaZD3boiFrALl
         By9n1ca2wrkdq6vvhda+GwsNR604LVD4DT2GtkNgh+HHxN0/CeJMhRH7Lqwjc/wyvcL5
         YwiA==
X-Forwarded-Encrypted: i=1; AJvYcCXeQiXJL98DHBlm4nYj4X9j/jftg4fbdywBuu5qZ0wR+RxG+2leBJiy8ZTJiu7S1EooDmvlbFSQfuogINM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLXfPIXyn8MBjKXEGzNGLi02aEs+ytCpv/EkyQ9B3xG8h/fYWZ
	FZvETf18qUMNbFkRKY3q5mNYSInXjMjtrGq1OlLdbBQ00Nm2pRl8BETj
X-Gm-Gg: ASbGncvLUVnwV8VSJ9DbeOtYoJ6Lfw0jcFJv8rNtfWjhM+LezfGglYNo46SIxJ6/NBA
	OfzoW5me2VNM99VJXJUytf6905a4V049Bx08TC4La3KHRd6q5jfHLgNXorJ+6APyPRXYS9SHUcn
	KLl79DdAmvfidLBopR37uD5L9totW32knNliERUI0Qt7C/XpmCbStdIq95BDasjJ0J/rqULV3aS
	qBoRMfsHoZiQljHfSczdx2p3YouASGVc1ajyid+BminQ/22ZmOc2XFRhoHJ+4Ur5N6yb+QKKFkm
	4DKgnNL/cIrj7krQ2M+65OICaLXiRbHV10UhkgiDElR4hvz3PudM/bDQKFuhNYc1w9DiMRmAGQZ
	iTnEsxVcZR/tBzaDfrZh9nS4Bf77rLwGzMvSwsTEQijvfzMulu5/ABdAtZ7WyKRY=
X-Google-Smtp-Source: AGHT+IF1yttvl4L2tr4zX6Joq9/P8wD3ZTZcShoXHQ51APk0j4wyc9+vVRT6vBgFrke+F29FPjCn2Q==
X-Received: by 2002:a05:622a:5e0b:b0:4b2:e14c:d901 with SMTP id d75a77b69052e-4b324feec41mr41569451cf.20.1756735935022;
        Mon, 01 Sep 2025 07:12:15 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6abc60sm63333301cf.37.2025.09.01.07.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 07:12:14 -0700 (PDT)
Message-ID: <ba1336ce-cc0d-4dcf-99ff-1934cb02372a@gmail.com>
Date: Mon, 1 Sep 2025 16:12:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: core: always verify OOB offset in
 mtd_check_oob_ops()
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250831-mtd-validate-ooboffs-v1-1-d3fdce7a8698@gmail.com>
 <874itmpcrs.fsf@bootlin.com>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <874itmpcrs.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Miquel,

2025. 09. 01. 14:39 keltezéssel, Miquel Raynal írta:

...

>> This behaviour is more accurate than the current one where most tests
>> are indicating successful writing of OOB data even that in fact nothing
>> gets written into the device, which is quite misleading.
>>
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> 
> Thanks a lot for this contribution, I'm ready to take it. Just one
> question, do you consider it should be backported? I would tend to
> answer yes to this question, which would involve you sending a v2 with:
> 
>        Fixes:
>        Cc: stable...
> 
> Otherwise I can take it as-is if you convince me it is not so relevant
> :-)

I can't convince even myself about that, so will send a v2. :)

Regards,
Gabor

