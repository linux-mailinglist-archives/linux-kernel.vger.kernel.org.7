Return-Path: <linux-kernel+bounces-793109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD57BB3CEB0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 20:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3821894434
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921692D0C7B;
	Sat, 30 Aug 2025 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuzVxLaP"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1325B30E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579038; cv=none; b=nKMgPNJC9tTdAdKI1+pXbIDkuYYIGSOm+rEdGcWH1YNpvxESgUFdh/h9iyUYkS5Bck4ZroMbIjyLJY5chl+/5a32eCG0/gluNlcORRS3wu/yn7o1Y5HbFeMkE59a7Bwvs/FVSsyPdw695lvgvnHIxPXtwbHSgsj1uFyLcyOEuB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579038; c=relaxed/simple;
	bh=67YPFASRAofFiaPQ4Q4cTTB5rA7J4glJA1NA06Fz9KI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LLvigArqfYupYNdxj17csm0qaXAbdaba0Icqg6FgQqJ1K7OOcHT0Htz5AGpVEEXF0+JFIPAaMfnl4AfcWLErft/thWq+L5Ku7m0MVV6Qj7nswQz4h123cxouySe29hHmQstULyb5J2/NzhsdrkL9rsYqZ8aFGyqBAYR2e84XO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuzVxLaP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b30d09dab5so26068461cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756579035; x=1757183835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=izmLCqreZNUIbi6uLE1hWRhil45KgxjUnPX1YnPsqCI=;
        b=JuzVxLaP3XTjb3/L605jfyWSK3IuRXXzlW/YIT5amo+reYRbTP+JA7QCYrLONED7b3
         kpC+w1GWUohle0FlRSl5DDNvdliCUnZRiJqpxA7Yq/QS7OYgqbMgrJUu7vLB1vyT6L8v
         1YjpV1rRbcwOiBjUEVPMZ0fsUju46wi7/gKqJJ7o1/+dLahYLG1eMoWOVp1D92u45zPz
         UuU14W2vcEeNZLE2AD74oME6Zbqxbbfxke+r4aj0u/I69FgmMe5HoE7CAo/cUsTBAbry
         FGr+51izS76CUJBVj2kBaF4q7f/sQGnjs3WMUUu2dcFFfJqsfx8BZoKWwOmr94LBIfBC
         rFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756579035; x=1757183835;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izmLCqreZNUIbi6uLE1hWRhil45KgxjUnPX1YnPsqCI=;
        b=b/vsfj8/UbWdAallj9AghyXZmJx0gJvg0NIW53X4bRO9nn72n2fVDOFFg2cX+Q5zWz
         c3pWZha2Ivi1btdYXYrM9/1gX3wmG6Ne+oODPY8JD1R+PCmwWBAf7ZVaFIHy3COQHJpG
         kA22UbzD18hfa/wyiIrnI3ZSnAUNHbIWntImZxe5hXdeVAwxGyToovgX7FKJMHx3fLbK
         TKap0DUfYD4ELgIYIPz7UwwpDi7SU+mx/UdzlX1ssYVxH+xXXBgyRM6vSpSIhe9befGd
         CCJAMdtkm3M8Je/eXdwP22Y+N6k67G0TeXgQio47PrZoGnJ2643FF8oOCm9BcbVCJN4X
         WBMQ==
X-Gm-Message-State: AOJu0YxggTs8A4KQBrC5InCRC09B5crlwyAg2RsVBl/aILGPXMLYxASv
	MfrVdbxpGaDcNOJAQ8SJNc1TER9hejXUnQc/uYgFHK2x3BiFeBucN8Hx
X-Gm-Gg: ASbGnctSROwOZxsQkX2pjNW3abaGWigEtA8nXuL4b4G1ilAADBlcHN9WQHazzuduGO4
	w4JqF3eyFDZTpJE51ntlusocI3/4yWm3s26rGbqrMpA0MEmz9QLL6cxXOnhfZEQxzrTfVb9CjTS
	1miEw4wGHb61sUMjR4oD6rCrGB95FRqd5fIrF4b2qFJ5/iWHHhSuhmViLS0yk550cu6ELelDbFC
	MuW7FQhWlQy44dta8XHOrT0sNG+/TQQWl8t833btu65Ewr2p9WmWUZDd13ztXhF5NNrasrkDsn1
	F+cxWBeI2rlhTa3v1fFa//ayLRcq++iPgsFL/B4POS8Kvrhdjar9XIADWGnP8ab8FyesI8hzeFR
	W5ndnCor+JttIgGPKfe1IMKY=
X-Google-Smtp-Source: AGHT+IHp+e1pL5PXmf5ztP0sp0Hq2OcymwgDZO4e1y8rfi8gVd++wRn3iO6l++VJ2o4Fd+iPXSxNtQ==
X-Received: by 2002:a05:622a:1a86:b0:4b1:2755:d884 with SMTP id d75a77b69052e-4b31d8445cdmr31357391cf.14.1756579035158;
        Sat, 30 Aug 2025 11:37:15 -0700 (PDT)
Received: from ideapad ([96.67.4.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b67bdfdsm35507661cf.32.2025.08.30.11.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 11:37:14 -0700 (PDT)
Date: Sat, 30 Aug 2025 14:37:12 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in bcsp_recv
Message-ID: <5e4ppwjfwtg7ruzkgyyke6vwosiro3vj6wm4hic3sjwh5bu7la@fghymhrnubbo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6z6oetkv6q6vaxvc"
Content-Disposition: inline
In-Reply-To: <67b0cc5b.050a0220.6f0b7.0014.GAE@google.com>


--6z6oetkv6q6vaxvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master

	Ivan Pravdin

--6z6oetkv6q6vaxvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="diff.txt"

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 664d82d1e613..591abe6d63dd 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -582,6 +582,9 @@ static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 	struct bcsp_struct *bcsp = hu->priv;
 	const unsigned char *ptr;
 
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
 	BT_DBG("hu %p count %d rx_state %d rx_count %ld",
 	       hu, count, bcsp->rx_state, bcsp->rx_count);
 

--6z6oetkv6q6vaxvc--

