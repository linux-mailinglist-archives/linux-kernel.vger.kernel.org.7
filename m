Return-Path: <linux-kernel+bounces-828528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A1AB94CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C6A7AFCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73429315D42;
	Tue, 23 Sep 2025 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oWhlp44n"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138F30FC09
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613000; cv=none; b=gKR7V6576i9+SjQ5iuOuIfrMp0JeqnnH8GoP+PTKZIVf5hAyJ0TQHE2H40creVC1FEBQCVo/JMwEOJNcNfCuVanyKxNYZSlpQpzh0ognPReS5PXSDMXx9M4PBoiq3dsU8NaRvk/+ZD14yDz5umx5ALEy2kebmeMO56mvt3tMQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613000; c=relaxed/simple;
	bh=Doy12JHJ1QdbigZcVC8weYmIDB/n15heyBBBZQGSXi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OV8ohRqK3goWqiyULcg17NZ7CoRdlQ2GE9CJKuhwn3Dmwmy+iiisOXL7CtykPP16Nu2Q6+inpJo9YcINbG+bSzHHzRTXFir5INWdtz8z+X5WfTU3LgOqjfs19JrRUJz57CU4SQd229jBO+R5p2+tEhUEDBJKLBk+irwCUCf5wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oWhlp44n; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6219257cb0fso689513eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758612997; x=1759217797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZTXYGDWrb7C8J087XBul2Wu+MAhbxhji+L53zCPt8c=;
        b=oWhlp44nWbXE2cJXE6nEObBKhC2kAzzpixfn/POM0yTXsgkVnkj5eQiJBMz1fW62D2
         zWz1nhZNrERMUwSgCt/6x0wGRSFlPMpz/BFeIsvHMp+hRjkzFIYttfnRiIzL2RxqZTZf
         A/MiqyWNkQDC8IH0ZIDC9BeVJs2RLOca4cxSCmIQghE1B30vrk5r19CC11U+3WCgVcvX
         F1VJvkv/lZkAcBnUFaU3Rg93J212sCCwTeZnj+47HD4JNyxrDxFgibOdnbrVgM2p8wKD
         GfinpsGMwQuaKCXtYB4utBkNjA237HU4uHpQoPfUiYo6n6MruUBi6sRlLvkDGRsjV5tm
         HiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758612997; x=1759217797;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZTXYGDWrb7C8J087XBul2Wu+MAhbxhji+L53zCPt8c=;
        b=bIFD4/SWuHmEBUK4gdqC6TksG0syOt07KrcolzEnKWSKhKGlp2RVNyiC/cxT3Z5znY
         CSHp4soRD0Z8131uas0oNHj2hl7o4fc5tYvmnGAxa+DaZZ0g0eTMyMgVrKn6ETJBv6QW
         NJ902MmU7wKpVWU3DtKoAaG7Eox/vZiLV28A9NE/Ozux7X590aVhZGxAFXozllOijakR
         93O3Y2TO1c0mOti0jMyM+Hp9a7V73HHmkhSU/E7Zxh/Ou0cfpSwDNa/utD/ySmQaAVqA
         TTHf0EpWX+jB/vrcJolWIKWwrRQdRE4wgArt+hpy2TL5I+ISglJu0DNpe1z6E7Vukbki
         EOqA==
X-Forwarded-Encrypted: i=1; AJvYcCXQTMMdLqigo5K2T5elUkkSxqg0uG7qp9IspJiCcySTtcwtydiExNIUI0CJfg7cy6mV4NNIAaCFZOSeqEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLoP0rCZ8QzR8APd8k2GapIT8KSLaMl2Nc9ZEmHKwLbwOu9MTC
	bYTcLx3uR5qrF6iIRQZWPkeXV80sjKQb2ejiPeAk84i6LVrYwF98ND78G9sV5OuidQA=
X-Gm-Gg: ASbGncv5VPj13qIQguY37e/5oqVRsG9/RexNGW5jXLUl6p+iDt+aq7HdlZv3BbcsHZg
	iVGteDiAxxcURXjuCQ2thMsU93PoFHKVxd7G2GTmZQbeSGZNAWKwn2iJ9+nlS/7hySsSt4Jwc10
	gZpFJVeY2WpBtC/k51OLi3NWjA8EM9Qysm7irzumWfdeRzT7wNxLGPs4Gxzn/Tj6L5vZlYT6ImU
	2Z9s34SG+WrRJeZVYg+Gu6X7pUqmPZONYCTauYn7iQ0kBeyMejbfcmFOHB0m9Ko5NSZLkIiXFbN
	7osD7MSietnXAoNNcim95S14p3C91RjMCeJqfpflN0Xpy0dB7uaMVUlbjkJmG4OF/fKeXzmiGiJ
	fvmAl870gQHDQ7fj1y70R
X-Google-Smtp-Source: AGHT+IGEnfNa5jqUIAzVSLji+rj40a8Wk8m3DmSZpsHkwIloLFM6TqzxMWEp36PzqFprqp3s5irrnA==
X-Received: by 2002:a05:6820:1c98:b0:621:9802:d183 with SMTP id 006d021491bc7-6330f72837cmr899233eaf.6.1758612997270;
        Tue, 23 Sep 2025 00:36:37 -0700 (PDT)
Received: from [127.0.0.1] ([2600:381:1d02:9377:13f5:b434:ef16:6886])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7691ac53551sm6971622a34.11.2025.09.23.00.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 00:36:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250923070101.3507251-1-yukuai1@huaweicloud.com>
References: <20250923070101.3507251-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-mq: fix null-ptr-deref in blk_mq_free_tags() from
 error path
Message-Id: <175861299450.153465.2022974135907413149.b4-ty@kernel.dk>
Date: Tue, 23 Sep 2025 01:36:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 23 Sep 2025 15:01:01 +0800, Yu Kuai wrote:
> blk_mq_free_tags() can be called after blk_mq_init_tags(), while
> tags->page_list is still not initialized, causing null-ptr-deref.
> 
> Fix this problem by initializing tags->page_list at blk_mq_init_tags(),
> meanwhile, also free tags directly from error path because there is no
> srcu barrier.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix null-ptr-deref in blk_mq_free_tags() from error path
      commit: 670bfe683850cb29957a9d71f997e9774eb24de6

Best regards,
-- 
Jens Axboe




