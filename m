Return-Path: <linux-kernel+bounces-813303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 810F7B54356
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCBE189F72F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6852729827E;
	Fri, 12 Sep 2025 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="nSe9+r/Z"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384F289E30
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659979; cv=none; b=Bo4u0HjLHDuOMyxnrH9wK+LBU8KjwYu6lcb0VmI/vqYjMZJxVf3DWyy0Bi1t5Skmv3r7gaJEsIP7lNZ93y6alvJFAeO0XI0lrsIN1lVTIIQHa/CSr9ga7a1ZEMSFzMjBYdJdTRg+8s2j8aziHNL83f6UfmC1McWrEFZKCrMR4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659979; c=relaxed/simple;
	bh=AMQ9UJhJn6NJ6YO0XjNRfud58VDObW+dwpThmQIOhd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPxZeE+stDL+Ff8JFpS68GtSrtGH6UniSghtVoyzSOVZ86HaxQw9DxJnb4QgLSDgoct18gjGWmMb5CK7C+4NUBSZ4FP+j+MS7wJlPavrP/kJ8YmgTo5gGDTDptwLaVqicJKMtNMVs04ROi6MviydAlCXgj64LTTLMP4yYZdjciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=nSe9+r/Z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso1628054b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757659978; x=1758264778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMQ9UJhJn6NJ6YO0XjNRfud58VDObW+dwpThmQIOhd8=;
        b=nSe9+r/ZU5y7WEJgrf9f3rUh1nS6uir2QVa1uhENhODP3KSZhst0fiV8hwOMzKe3uV
         BaXXTCHv7KBAQcEhfcXOYvF0AFuOzMOPY8u0hpVN7GDLeAxRyEOckWk5sD2PXkPIv0xg
         hx7VMz6C0YF6URuzBm0+PlinXwn3/cUi6RHIR+vNHqPW+du2i0dFk1qf7jnnYYcjzi7I
         crwNb53jn0Dt3y/rVPffjs+Nzh81BOZOZLT4iwUQzdKLzd+ZDi2ipqBHsBkb26TEJInc
         Zy6iq8s8ufk66lTTGc7ZOnUdpIWOdVM0shpZPuB4XpCoQZxg3akIVNVIYw5GDpfXUqqa
         RQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659978; x=1758264778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMQ9UJhJn6NJ6YO0XjNRfud58VDObW+dwpThmQIOhd8=;
        b=M947ehq2nxLMkBfe7QU6AqNHfadJ6CdmUXZjs7ZYIiEfwp7BZUDtl+o5hBOKoVundt
         DqSbexapcTD1OyyDCfu2IhT0SlacMk2aXvKhyi8PKlWHKk0nbl4vsytrKH6qA3In9xjo
         rZ4cxKb5pROnn8fR/iYGV+Pr8oPt1MDwR+DcOYJdCowqTAViCI/Dr08JXRcZokqbx8Om
         Ks82nHBr4JRcgSG3up/wBP+N1NYPXOJih0KC/sSd3fJ1czQLE/VlBbj+BuNST/Z+kDp1
         eol1o4IyMdDq810rAxdMm/ALtsORK6d4Et1pL0/Ude8pX0E5g8Vrnpfr4mA0NcTs6L+u
         Ycwg==
X-Forwarded-Encrypted: i=1; AJvYcCV554jN0s6Ddpu6gmay+Dcx5VOJoG2j81KmLAGufxYkPU4I+ekl5aNE+eZvqkmn4wNX8ZoYucUqGiaOM1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7es645PWDdo+WKjyfO4HXADxuU6yvFxrGDOOar3R2km80cVSt
	kmiMfntuJVM+A20xGrxPT82pArQ1I7QHddfb4n8Idji+jn2stXX6PSf59r2X4sWVHsw=
X-Gm-Gg: ASbGncsWYddbogLcqNIwxWv06uSGf9MU7/h0mOori4A3CgYbnJYtQJn+AiQbbIDyN5r
	lENXG+ck4iS3pp/67Op5al2gHWx365nKy9QTp7icf26qe8sErFckGCCX27bTnqIsg7iUuj/EPgz
	kQggM1kH+wxUpcHWh/AmsBxgeZVpaa2RVc1xgyHCB9vW6sgs/Logz7skdUiG0Z9m3wFDbKZDv5J
	UvV/HwJ6GX8QasqpXnZwIkUusYn/CXXlEF1OlzoJGuspqr9B2QC0KzG1XzIQg9n4X6a2JTqbu3O
	GQipoImmmAMgyCR5cdqTLEIUmZB4aLWuEJH9P0FrK092Iw9KL/HKpJZHhVLnA/FqF+N7ZpuGN3i
	xJC27hL6MA4UnqzVVl3Pm0PUsgiUfTOmysi3Db+WXxAJ0MZk=
X-Google-Smtp-Source: AGHT+IFQKeePLPos3Wc/vCSrtfD9DK3M1OpdAn6C2aQwDSA3Qht9Qgg36mVj/vePp62ddGIi74wlig==
X-Received: by 2002:a05:6a00:2ea2:b0:76e:2eff:7ae9 with SMTP id d2e1a72fcca58-77612092482mr1980655b3a.12.1757659977712;
        Thu, 11 Sep 2025 23:52:57 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:9e14:1074:637d:9ff6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c49fe4sm4410985b3a.101.2025.09.11.23.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:52:56 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: 409411716@gms.tku.edu.tw
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	ceph-devel@vger.kernel.org,
	ebiggers@kernel.org,
	hch@lst.de,
	home7438072@gmail.com,
	idryomov@gmail.com,
	jaegeuk@kernel.org,
	kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	tytso@mit.edu,
	visitorckw@gmail.com,
	xiubli@redhat.com
Subject: Re: [PATCH v2 2/5] lib/base64: rework encoder/decoder with customizable support and update nvme-auth
Date: Fri, 12 Sep 2025 14:52:52 +0800
Message-Id: <20250912065252.857420-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aMO/woLrAN7bn9Fd@wu-Pro-E500-G6-WS720T>
References: <aMO/woLrAN7bn9Fd@wu-Pro-E500-G6-WS720T>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, please ignore my previous email. My email client was not configured correctly.

Best regards,
Guan-chun

