Return-Path: <linux-kernel+bounces-795500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C67CB3F300
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB21A4811B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1862E092D;
	Tue,  2 Sep 2025 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWFZi5hd"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6492A2E03ED
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756785177; cv=none; b=GUaCsOuJ0gYlO36G3UG/BAoVYn4DdMzHM+8hZrjl7RvyzjvZBKEetpa9dtGEA5+Og0WxoeysCm5Tfh3O7llhUDvZtWicBvFeFGsdx5YlVpWaqpv47OTjytMk33bOvGvO4E+UGeis+ZmUTZ7U78pGLjui9xN2Zf5khkfbZ077O0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756785177; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSYKHDsEI3rOJe1vNvs6n3c3FfB7xBot5z4p5ziXgADyux7miGdDCwWiO21trYRm0vnmDoUTGMglTI+jlfCRyE1m1+qTRF90dWXo/reFCW09/eu2VXWcHm98fdikaqGFqa7FHVolveCb23g5kVK/0EhbFRVIav8yR8WTmhY189o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWFZi5hd; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4d4881897cso2265012a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 20:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756785176; x=1757389976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=RWFZi5hduypSHnAJYuJgCuZNymX+/m9qnBsKS5hfgRHUgJUtKnCZcAE8Qf0jdlA2Zf
         Nyb6n2/GZEYcn6Q7dG8vN9Pai5mqSv/pE8KnByDLoBrU6M8Ud/bw2S6gbL9ShyluN7b8
         QFUMjmhE/l9+rLyYeho5naNFrPeHBL/uriqmAIPSROMZtEt8hk5GeUNS7kZ0gcB0yQjJ
         OcV4alqZHrStrmUZMJqLtSirYQutPMl28MLSp4QaJIm9MNw2Bg3KhROjqlicC+ON1cT6
         5rhz3Fjb8rvjlAKaGvUlegAy8JMKQv2ADnKBSEG7wtA5wM4/JeNU62Jh/3BuRPH3W/Yg
         4DNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756785176; x=1757389976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=KGKertvtXBASuqKr5SOjiFYC3JGCKF+iRnQGY4eDDSYVx9GU3yzaGrLAVWh9YPv5V1
         58pdQqF7TsA1VPaMQ3AgdktewBwFzD6ICKb0vOBpnlrjIIf6qmV6u055BQbXh3the9VI
         b3i/xmiCzYEbMxXjJSEy/M+BYvHufV6H8fpI+2w3Oy/NhKP+2q8ajleRlrhmPNb+A8KU
         U7MdwEtAKA5phnv2s5Zze9xkZipYJjzcn81BgTvqyUYM1qcpgudPX2rGfIA+ofsSPEqx
         mxnEDB07xGpuf7oDhsUgOInvlBRg3Vpv0lEOwVXIp6ZKKqdFAfoVNWtKL0LUOA1Vv5fA
         842g==
X-Forwarded-Encrypted: i=1; AJvYcCXMS1zfGu+4Egh94ynGNNpBbFBPglcAvgQHuQbKzFEgUQhLyLwUweDUhL5U/uCXpkwjuzMZfGUYGnZ0PI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7IQRpJqVhyGnniVttzgw41RatmiQjPAY6ShcCxVpOh40osFHN
	YotoDKV0k54+GfgkfS0xiyWmY1NBaExK8WU+TFRbC0k3CwjGQicMs6Af
X-Gm-Gg: ASbGncsvv8fReiP3xj20nH+T2rzz7O/WB/vSyKJOwBp5PVAJV4gflW339J14TZqvzoS
	x9404HT0SPabS9Al+6PIzM4LFcGSHvP4xIthSfWi+exDUjyTd0bcaLAiYRg1RBBskD8VWq4TBkk
	/hwJjIELhr5vTXey17RdHYMn6J0doLmMGBar2xOId9/P4Temzh9xnJaRuIRiLJF/WHsw3SCu+rK
	0mpHUjrNCVnOrKVmSvX39dAGci0j9ceu4htRsPsI58vNbEuqHIfquymMdhZukH8WgH58pY+HYGZ
	+Nqkxf5qbMSdloDfw77mM3BNlGRN8WHEDHqeFMWBb+ZMys0EySPxVuqzJNAN1ewmqzHjUTfmM7g
	yD8KsjPME+zjMICzGk196Ommt+FjDQ+4=
X-Google-Smtp-Source: AGHT+IHU8gJftawp7s51YQ17h5RUFPMA5po+re9SQp45a+SalBokhfUZmGtjeU0WxZj4ETJ2eTvoIQ==
X-Received: by 2002:a17:902:ce8e:b0:24a:d582:fbaa with SMTP id d9443c01a7336-24ad582ff65mr76788865ad.12.1756785175638;
        Mon, 01 Sep 2025 20:52:55 -0700 (PDT)
Received: from bogon.. ([106.120.127.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648d67dsm118276045ad.108.2025.09.01.20.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:52:55 -0700 (PDT)
From: Tingyin Duan <tingyin.duan@gmail.com>
To: yu.c.chen@intel.com
Cc: aubrey.li@intel.com,
	bsegall@google.com,
	cyy@cyyself.name,
	dietmar.eggemann@arm.com,
	gautham.shenoy@amd.com,
	hdanton@sina.com,
	jianyong.wu@outlook.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	len.brown@intel.com,
	libo.chen@oracle.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sshegde@linux.ibm.com,
	tim.c.chen@linux.intel.com,
	tingyin.duan@gmail.com,
	vernhao@tencent.com,
	vincent.guittot@linaro.org,
	vineethr@linux.ibm.com,
	vschneid@redhat.com,
	yu.chen.surf@gmail.com,
	zhao1.liu@intel.com
Subject: Re: [RFC PATCH v4 25/28] sched: Skip cache aware scheduling if the process has many active threads
Date: Tue,  2 Sep 2025 11:52:43 +0800
Message-ID: <20250902035243.193544-1-tingyin.duan@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <463bc54a283c1b908ea286ce67f301e2d1d39ea1.1754712565.git.tim.c.chen@linux.intel.com>
References: <463bc54a283c1b908ea286ce67f301e2d1d39ea1.1754712565.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


