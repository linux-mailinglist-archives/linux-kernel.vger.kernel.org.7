Return-Path: <linux-kernel+bounces-758180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2527B1CC0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6C318C24BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0774529CB49;
	Wed,  6 Aug 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiUH4U8I"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11029C344
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505623; cv=none; b=AtUafiVfCsBgX5MlQZEOWzyOnGXT0ePvvGUwq98sOir7Q3jUaOMOB9DRnfli2AeU+kJ65Sp140+i8uKTn3EOcxYcHzCtIHfakkcEqqSgqHU1dUp0dloR9JY+PP5b0j4GHwfcgAX0q/912C99EglUekOCZeeC5F1O9thky0QdDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505623; c=relaxed/simple;
	bh=8ANG09BXwUJaoIXi1mJ0w22aJFvE+4j3gy12dJ5Wq34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgXAf7ftQd4m8s6UiRogyXBFrGFoG+Ga5WgROydKGAeeH1swN8KC1iozQXbxbDhiUteittc8ccQlgRGcL3OLfeM1RAuKpSXJaLvNve9GPYTgT77qFGkv/is0fqNIX8ACjQxN886HAtVexjzTz+I7UMPrUKepkBdAadvWSEZ6k+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiUH4U8I; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so2222235e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754505620; x=1755110420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNr8/snCMDeN3hnWgTzW7w5ASTFc/odDoWi1wihy0vo=;
        b=WiUH4U8IJ2SE24oQ9t9WvORbc3BudLFYNkEubFbtpyhuKSkHFnU+AdqCrz7oXuamy9
         duY/f6UnZYgDVuHfOjDHJY/bAtGoBQYhcoBWfDQzDx8VczqRfOvjiQCtMm3B2y2Ajq2p
         kZ/Lkop6eVzG/Gd4mMgb7oGjd2MdK8ZGHAT2tDXNPqjfmVfSmXM+Iwi74+5UAb7E8Q6O
         9dFSxh2zkuBC8scp/PlXPymmzqtmiqXAc7sjcywfhxKyz75eqiEuvBCzl/GkoI9LagIu
         8dNCwGsGlSEmWUGyvsZQ60R4CbTo28OZEK6w62dqC7D3Tts5ZYsRj19PZV9HPMJ+Tz40
         NuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754505620; x=1755110420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNr8/snCMDeN3hnWgTzW7w5ASTFc/odDoWi1wihy0vo=;
        b=NOOzc/x8V6ZaE8fjiw4iuCESb1CGOsL040jTVWGkafjUFbO/QceVeUHX3eF1zNOdHj
         G+F64zRDYyyyZAOtqQXwb8PVuVX/bO5EjaHG9DpYUTJ2OSxgMdHRbDfRDotefLsOlb1U
         RX8SYR3DgDo0JQ/a/ZMJeqspcgNpmV5CdoAJT9kkdnpXxAz3U9BejFo3X8FT01O1a1pP
         vDhOYga/uzfsJUAHgQVxOzsoYYJz5RDwwdIHwD96xiHpfEglQ+SD+gvAWmAeD/aK6kY7
         1RIU0vbu09SrQc/QeWZswGbRNuoHJB0x+JnEC5XiWzooGcRMz39zbnA7eaaeqZMLrsD+
         6oCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPWaHcUS48V1vyRkx0DAc0dQNkaH+WwUzZrSXg5s++SsvSsoLspxa86uLsUa3H6vliEsyFK+2Akzk1ppw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXknuHK9JkAWAF78uUKS6ZoYc3eGxHy/tVoaKeD1aind4RfjnU
	OGxLUHYl+GqA6vVxC0IJEgDQJxzpw5v1dxqnd0VazOqpA1L5m2APFo48
X-Gm-Gg: ASbGncs6y4OywJrsM++YMYPGKTro30KyfJzIk/WxoUCfuLSaZH8i5i4nYvTY4skOVtm
	/9k6PLemsGchZk6rrglPPuwXRwSxE5K+BDJhb8+FuLZW2pdIcxI97gcDF3Do/mBclm5BE60Va2Z
	sNdvplMei+MFV/YO42vrCWwht5JxKiM+bVncgJp6yB/v5Hefxu0FVQn3ihws08JMfLyDs87v27W
	TBmFXOcTGUMsF1Wgk9YBTZTi3/08NBiTVECnfRlrZpAMf2muF4V0T5KaxL/LZekvQgOmwxejRJU
	XDxRRzWYkW0t5mSeyoabDtDrMIO7QDky9PZ8u1tpIPDMzot4c+S1znSxhUR44OsCjeO5ZFDOCdu
	ck7SmyCFvckfqm0VaztJ2gx7bQD+loiFSCFM72+UJU4L7Q5j4G8tDchS1mbpCJn4=
X-Google-Smtp-Source: AGHT+IFCDKHBNM5kd667rpnROYOoMUbhrX6INHHFpN704TYBAwda9yAk9b+asOk7lKATso1Pm/Zinw==
X-Received: by 2002:a05:600c:3b1b:b0:456:43d:1198 with SMTP id 5b1f17b1804b1-459e74b8340mr30220515e9.32.1754505619467;
        Wed, 06 Aug 2025 11:40:19 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e075805csm104393635e9.4.2025.08.06.11.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 11:40:18 -0700 (PDT)
Message-ID: <25dcf103-3cd3-400a-b402-cbb5f23006c9@gmail.com>
Date: Wed, 6 Aug 2025 20:40:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: expose ooblayout information via sysfs
Content-Language: hu
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20250719-mtd-ooblayout-sysfs-v1-1-e0d68d872e17@gmail.com>
 <87tt2ley48.fsf@bootlin.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <87tt2ley48.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Miquel,

2025. 08. 06. 8:57 keltezéssel, Miquel Raynal írta:
> Hello Gabor,
> 
> On 19/07/2025 at 14:06:48 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:
> 
>> Add two new sysfs device attributes which allows to determine the OOB
>> layout used by a given MTD device. This can be useful to verify the
>> current layout during driver development without adding extra debug
>> code. The exposed information also makes it easier to analyze NAND
>> dumps without the need of cravling out the layout from the driver
>> code.
> 
> I would prefer a debugfs entry, as this is mostly focusing on
> development and debugging purposes. sysfs has a stable API, which makes
> it a less relevant place in this case.

Sorry, it seems that I misunderstood the ABI documentation.

Since the 'sysfs-class-mtd' file is under the 'testing' directory within
'Documentation/ABI' I thought that it can be extended by attributes used for
testing purposes. Additionally, the 'oobavail' and 'oobsize' attributes are
exposed via sysfs, so it seemed to be a logical place for the new oob related ones.

Nevertheless, I will check what can I do with the debugfs based approach.

Thanks,
Gabor

