Return-Path: <linux-kernel+bounces-726670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECAEB00FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106E316EAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96CF295DAA;
	Thu, 10 Jul 2025 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="Am9DF6jt"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC483187554
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191752; cv=none; b=hnQOuWXdbJT3gPoZ8j1SQs+NMTgooU5gmyJPj0bTEgIRSJ0aYHGq9Gnwubuc7UoWfAlmzXAlgvPf+YwkUYwXq/S4YMoh18NQ/3dkhCdPvCIDNvO1JV2IzGEedim8E2x/rN+QpIyN94l7cl993IwmV0kG3z+G1MLLZZUnlLaXP/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191752; c=relaxed/simple;
	bh=XAiCmdF7RkApsrZzspm68HM57eB+JOIvtiEXT38QR50=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=GipmlyhwtvzXmwCIYP58dhfU9uGcCOZLZR9ZMfJ3d+ajN89poGCeGEJjDAY1db5H/AWL5sBjXXwdQC+EejtDlBQ6qL1++xnb3gonDykekK5OfAuRSG3Frjt8pZiVMGL02UwScFySeKtMGldmnTzI0ct4uXobMEfYDuht0Lbs2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=Am9DF6jt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235d6de331fso19405945ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752191750; x=1752796550; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAiCmdF7RkApsrZzspm68HM57eB+JOIvtiEXT38QR50=;
        b=Am9DF6jtw/yWWBzwGKYWrg4FN0x/dS2+LRyOIdOKXIEnCM3qUMkOl560yhFAtLdXYj
         PGhR5hu7+dW06McMVyvAwsrZFYDkkthJfS98vHV67m06krxreryFOlc8gcDPPByp7MT7
         wOQYQPTBG3Fu1yzWjVkGdCD7BWy4mMEFmuHOsId6G6hGSmz4bUoLImBnz3oHOpTsMugz
         LlfhYJQ3x0KdAvUw/TN8BI4tSVMijUdBi0Lv55gJzk8pDnY6xwXW48htzhaU/CML1kq3
         60yBpmWBDOv8eAdk2Ytsv9t81eX4QLmNsI9wgAtylgdosOOMfNO9rGkPCE8R+V2kQfh7
         Wmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191750; x=1752796550;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XAiCmdF7RkApsrZzspm68HM57eB+JOIvtiEXT38QR50=;
        b=uld2IPniey28tZfHASkAjRQ1/8ccrAbiyMJX/V4OKn6xN39JWrh8DhuGHZoAHnHIrg
         DbSrt5TaKMo+ltAT1n4FHKhst8yVdonDbtuUAD36eTGRomA67Ig5vl1ZJlIu771HfC1f
         SnnbP6ApI8I3pfaMuBqjTxxAGRTHUYUqI6o11RkYEAF02vEdvx/uCIeIaoA00PMr3fMV
         l82R+XKq+ujwo3Wr2+LG5xbArjmPj4qT0cOJmQPJY49Nm9s0ZaAM79STW13iMkRGzAu7
         aM0Fp7WivPrD8gNJqp0F8OMqAKglqCNX89dmPiCldN2OODQiw3IjZfyWqUZgKk1YH1tH
         dJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVza9VBj89sNAWNaS0G3z3gkxc8iTiI3LSMbi3+MzT6RZTuY6zJnGW6mrdJB7AidaSE//Azr+VN5sVRQbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpI3ZZayqxG4/jFw0xLK1qrJm0U68gO0IseIMiyGV63/pwWnt
	9ay8D2xQ3BxoWd6Yfv8zyFp+e570n9WwaTZ7FLbNzDPCKon7Lxr3fgUYzUGJMiz8XEc=
X-Gm-Gg: ASbGncvvwyXv5M5fhhJVJ6TsVDngdhhFGSvKPSLNhCchjpPpIBH3xtcg7D4+BJXSBrc
	XM4Wy/bsezn4rsO1bLRBWtxJcqCHcgfBVy7H5obYLzj/NvmTMXJJWiZ2iRb33qRohcdptP1Q5tf
	vCIzwlwFtFvjWFfDp+NbFeMGwG2/8VkQzrNw1a85mdcuYt8Fruq84ZJklSyiL5cNIvbZzbHhSMQ
	ujiNS739SmBGRDoPBEckB7ChRSOWtYRTSGS3+curZrxMGHjNBTmgCnh8UnjknAJmEcLA0oTxxls
	8kCOwmCR6Pmr1IBAmevHRNTU4G/A+X8juQjk8O6DQODtkiOKtjRFOjjGPg+BlNsmHwzusd1Y1zT
	K/7Oxcjp7D4Rcdlt4Bso=
X-Google-Smtp-Source: AGHT+IGFOD84u48rdMoEXoU5fk8FMmvZ6/jUey0yaBE6/wbev3/1XX3T9b4F6Rm6Kh49JQ9zptu2AQ==
X-Received: by 2002:a17:903:3df1:b0:235:be0:db53 with SMTP id d9443c01a7336-23dede98446mr11872605ad.51.1752191750126;
        Thu, 10 Jul 2025 16:55:50 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4365b10sm31581145ad.240.2025.07.10.16.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 16:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 17:55:47 -0600
Message-Id: <DB8S4WLTG1SS.NVODTL6KNFXF@brighamcampbell.com>
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "David Hunter" <david.hunter.linux@gmail.com>,
 =?utf-8?q?Hanne-Lotta_M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>,
 <mchehab@kernel.org>
Cc: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kernel-mentees@lists.linux.dev>, <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4] media: Documentation: Improve grammar in DVB API
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250708155206.91281-1-hannelotta@gmail.com>
 <680b91c0-0fae-4230-9fa1-da988cb82e65@gmail.com>
In-Reply-To: <680b91c0-0fae-4230-9fa1-da988cb82e65@gmail.com>

On Wed Jul 9, 2025 at 10:22 PM MDT, David Hunter wrote:
> On 7/8/25 11:52, Hanne-Lotta M=C3=A4enp=C3=A4=C3=A4 wrote:
>> Fix typos and punctuation and improve grammar in documentation.
>>=20
>> Signed-off-by: Hanne-Lotta M=C3=A4enp=C3=A4=C3=A4 <hannelotta@gmail.com>
>
> Overall, good work. Here is a suggestion for future patch series:
>
> Subsequent versions of patch series should be posted as replies in the sa=
me thread. Currently, each version is its own independent thread, which mak=
es it hard to track changes. This link has the documentation for the proper=
 way to handle subsequent patches:
>
> https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html
>
> The relevant part starts at "To that end, send them as replies to either.=
.."

This documentation you've linked is specific to git, not the linux
kernel.

The kernel documentation argues against doing what you suggest [1]: "for
a multi-patch series, it is generally best to avoid using In-Reply-To:
to link to older versions of the series. This way multiple versions of
the patch don=E2=80=99t become an unmanageable forest of references in emai=
l
clients."

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

>
> Another good practice is to have the previous versions' links from "lore.=
kernel.org" directly in the change log.=20
>
> Thanks,=20
> David Hunter

Nice work, as usual, Hanne-Lotta.

Brigham


