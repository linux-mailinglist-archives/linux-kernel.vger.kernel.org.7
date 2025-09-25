Return-Path: <linux-kernel+bounces-832784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFACBA0613
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931935E04C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0836427FD51;
	Thu, 25 Sep 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f90Q2eyg"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35632E6112
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814215; cv=none; b=QVkYxlI7cyWGJEwHC7V8ip58ABfmsyGqHUY1DZ7kPNiPsU+lW48cEciV/CcvYxAfJughOMURO9Mrjze1Uqvtu+fpEd8nLQy0mxIFbtu2JsNUQIWI2u9eLfpaXn+/WrSX6Z0x1caN21gfC82qZusa726h+qnLasIxaPMVtac35qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814215; c=relaxed/simple;
	bh=7embYRPF/5Q9/8iByQGHRwo8kMx6aLILpJkp6lh8BDQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oWrQh4fyPDV8xquq61ejgWZQtcp8+2oWFWtVxp7HCfvHQmWEFyHmbiCfcy3tYAMvkqEjdaeFWX/lBMGMzCjXfrSRFwdOCKQ7rQVUiD2TkW/PQlAvhprDSD54CQ3qLdzjGJYnwBikyv3OINhyKaG9SAo045rWYywmKzwR0wDavpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f90Q2eyg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ecdd162cd1so66876f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758814211; x=1759419011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VF1Bqi8k7PXZlzWvyUXBJx9B9dWwFCwidqruMuP4DAw=;
        b=f90Q2eygaG4dc0yryHBMGZQ6RAsDgj/qQVgiqBJg0uemvGk1G1YyRGRLOAbfMUpdJm
         BDs7s6e7VxAbWWzDRwOpYu9HORzi3yPg7qWBHSMIia7wp3bcEvRl54Qd5k3Ol26KF0Iz
         XFMx0v41u4bQrq0PVQrn6t0G8kz8gM0V7BGPkxShESZFW6j+NdHFN4OS4xqsFMRZN1go
         1j0aWZOCGvqZ1DG1aueIzp3qrCMgL9XJqDOKosOnktamH/HVkmuChXLg5fQAAQMo4mcD
         PuihuQ3DyvW+FhF7pXrobXvTv3GVwYpcjJRxVkKbYjWGi9lo69fMf/gHakOqNWaG0dAi
         fw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758814211; x=1759419011;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VF1Bqi8k7PXZlzWvyUXBJx9B9dWwFCwidqruMuP4DAw=;
        b=acJXYwXXqzZn3eFb2pDm2YOQJZ1DswOqV2WpoqnxOTJ1VG0so8A1g49GC3SbwR6A+0
         Cg/vdjnFNiZCLYJfnIRuJeImR2UQpsXQOovXid7tDJ6/Q6sc2iSiKSQppKMGnbO35Ybe
         cXViAUdmY7Qj6Nbq3xy9Qo+On5GCebjfdAF652noe1Ae3LVT9lHxiixfklfaf3aQ3Z37
         ChIONtX8jxwdPoC4vNo68q0pdrqjs0SgPP61niVMO8TEWLFl8Qrdsr3DsVUgan0LNvxr
         467jqg0kJWeBYS+JEFzjUNB0iYkzKcWj5c/QHLpGCq5875NeK1LBPsluzDv0ipZQXoFp
         6jGg==
X-Forwarded-Encrypted: i=1; AJvYcCUKRnS5lVEf46vIBlirCTSSSh9h1vZbQwSckhBF7t22dQeTK03MPJbmCoRvTKuSNUHtu4olKF5pbvRBPM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFXZeQ/JuW1bKAfRj34GrmAuFtg5hM7YAty5T4crOTGpGTIFC
	AuxR7k+0dXv1JmRjM/M58OSEcBAmnLlv24K1DuEae+z43VdjmaYvVeY=
X-Gm-Gg: ASbGncsaO7CBM91JQ8na1Chf3oHszD+iaz3v9KOjBXC+/dj+RXgQhR83Dou+uzwYNCM
	j/LguEM+DChxFLYNYwyQ58PpV5yBNlHBcguwejUVrtuP6oc+HtGN546zDRN/UeWRiqQ6Qf9d8zb
	NIyd6JSCDFiTyc2XdnO0Sh25mc6CXHwhkJ17AUpkjW34uEx5nWat+u2bciFyY9sB110B00q3A9l
	Mb5/0ydlDraw+VUJ4zpPxJcJrCQpcRzfsVljJ6xh7iElamsOSXLedimGCQUL3WepDe8ij7azKj8
	46J0hIca5+xvz02RWyeX2uFoatK6kWXTSl/Yy2mzBkvW6MKMJDO/2q2sGDgnPEwzFdJXP+o+aPW
	Z2WH1+BfLc8aduNwu1X9bIRJLi1pakq/vwIZM2S/u+bH4lZzgBXiuKXH5GRkR
X-Google-Smtp-Source: AGHT+IFqiPDWCPZpM+LXT8lqt7ta4cimw64WrasTX61w6SM4yI70RjOESL5EB0LuI187Xe9we0NonQ==
X-Received: by 2002:a05:6000:2a89:b0:3ec:db87:e8a9 with SMTP id ffacd0b85a97d-40e3ab888bfmr1778010f8f.0.1758814210739;
        Thu, 25 Sep 2025 08:30:10 -0700 (PDT)
Received: from localhost (20.red-80-39-32.staticip.rima-tde.net. [80.39.32.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9c32734sm3546318f8f.25.2025.09.25.08.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 08:30:10 -0700 (PDT)
Message-ID: <8056aa80-7e5a-4cb3-804c-d9c7f8bd6d55@gmail.com>
Date: Thu, 25 Sep 2025 17:30:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 14/15] scsi: qla2xxx: add back SRR support
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: Tony Battersby <tonyb@cybernetics.com>,
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, target-devel@vger.kernel.org,
 scst-devel@lists.sourceforge.net, KERNEL ML <linux-kernel@vger.kernel.org>
References: <f8977250-638c-4d7d-ac0c-65f742b8d535@cybernetics.com>
 <2cc10189-6953-428e-b34e-b1c714fc0eae@cybernetics.com>
 <0669b097-0bf1-4895-9c2a-5e953aebbfab@gmail.com>
Content-Language: en-US, en-GB, es-ES
In-Reply-To: <0669b097-0bf1-4895-9c2a-5e953aebbfab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 2:49 PM, Xose Vazquez Perez wrote:

> If you want to review the firmware changelog, mainly: FCD-1183 (FCD-371, ER147301), FCD-259, ER146998
> (from 9.00.00 to 9.15.05 [06/10/25]):
> https://www.marvell.com/content/dam/marvell/en/drivers/2025-06-10-release/fw_release_notes/Fibre_Channel_Firmware_Release_Notes.pdf
> 
> It's look like all 2{678}xx devices/chips are affected by this bug.
> Perhaps the Marvel crew could provide more information on this.

267x, or older, is still on 8.08, so apparently it's free of this bug:
https://www.marvell.com/content/dam/marvell/en/drivers/release-matrix/release-matrix-qlogic-fc-sw-posting-by-release-matrix.pdf

2870 / 2770 :        9.15.06 FW
2740 / 2760 / 269x : 9.15.01 FW
267x :               8.08.231 FW

