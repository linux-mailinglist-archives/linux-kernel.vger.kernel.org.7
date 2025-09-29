Return-Path: <linux-kernel+bounces-836487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75918BA9D56
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 568D94E1E19
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B44130C101;
	Mon, 29 Sep 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XURxbhKl"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BFA23536B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160756; cv=none; b=tIRUSYLHWpWLA+pgRnuWSJ+0TESnv3VmKSUJZ/ApAZaJi0uaontoUrhmgJ6+aYxZ2rmIRt69DXstjLNaH5fwrrFV4Vjf19Z5kyy7cjqCdfThAJ8TR8UwU9khzbirYsJtl+Cns7Xt9l/LrYgx5BBnycUBiexPA+2Ep219yv55TrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160756; c=relaxed/simple;
	bh=HMVoh979jXl54uDftd/1Xx6tkyfIhAEBek0tPrP+Teo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkOMFrpsfY21tYR3Cuv5YMwrLdzUq7jPjGk6Ty/0g254MPl6BLXVtSFBUlymmEku2ZBUplT9dscV1s3HrSbu9uKT6kKVnA+KxooRz6V1fP471xC6qGj7R9+SKdGg0FOkz8qhdW64EUojFAPmHqlxfuN0HPeeJoUBgp1S/v1oFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XURxbhKl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782bfd0a977so1360667b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759160755; x=1759765555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qipWkB9/4eXftP05+/i6SMamlcpTwPzfnVCspDoPT1Q=;
        b=XURxbhKl4oJDrBG54M9Rw5VRxyd8BR0VK5yDZ0W4wOX62imMdQ/OCphQQHtzsvcY0O
         9lbihRE8MpcaekQCMlq1UKdm2c2bPhnK1vBZEaZcdnL9g3Y4EkCVbhWtHOj3Kt0go1kw
         SM0spX84Jyh6zP7KJi+m7DR8J4TyJUEK9eRiZapY6Csl595NM9rd9ndreUfFfLKpz7Eg
         XB3ujM94fISwHnpo9jvH4B7nImarl9WAilN2UmMVbmyoO0MlWeLLBUIxBBgbPow6qOJU
         sme65whlYodKlODBM5PdE7cQXCdi76SkghmGYlGGDzonwyOTFKpWMZOVkW/Jodgla6uM
         HnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759160755; x=1759765555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qipWkB9/4eXftP05+/i6SMamlcpTwPzfnVCspDoPT1Q=;
        b=xAdTftXOAfJ6C2VwQvMgTZfAkgIU2xyiy3+4za7ommpnyF6HAkcH3r18ozj+RAmvi4
         HDVBw/Mu4gPPBKaU1T9XwaFfTHyYT9oj1V6IoMiqMNywm/CFCoBVnfY1kIT09psT+1tS
         TZTbPAJzAcWzVGz5eDiq88voPoD08irmJd7SWeDgxwuNXWxcOlS7Q9Cm1Pdk83rdrnxw
         bV8eoAsVa+dhGanM/embHxgk/K40FqwKJHZBYhZSQwDBIbrYz94G23OajHnt+9yQ3OJp
         Un+omudOUt3L/V9eg0gm2rHWlPv1SBS+U9wH+vf5u6m9utL3/s4zzlf8YoiyWjhY+Uef
         ratg==
X-Forwarded-Encrypted: i=1; AJvYcCUWzz71xyfsiW2x/8LZoDwyaxCTtn66DCKt3QbURmE/HyOJAWmohdlQlYCfsv3zdjXAFL/B679UYas1eUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSGvPmHZvk8V1Vg+HBJkxF1y4dQS/Qomh+gQEGBv7VP3qjGAdn
	VufynNVqbZAOq+H3h3ZEiuUOD+EUULdCHgAAJSGvnRG/qxJBbVmnkcUG
X-Gm-Gg: ASbGncvS1dxjPPeNPV0K8kuXMzyv2PpHYaiD3LhGYB+FCmvWTkOW4y70cOBFUUpFnuP
	MBXGolGq5VTY9GMPG5MD0Wpt8TH3ab5fuF1Ar0+DlyZ+6fNvkx3pmDVF7V0BpsXqfhKE0xvAQ9V
	KsapzAl/J5oxGM8UgUMUApk6uViRGhVEdoAv/6VLkgf1OLBFagAqUlKpYCltePxP3iGH0G7xshR
	Andnxy/tmbj2u2FhfpKDKHEUgZltj6sNiiuFt8dcoTa+XSukyVg7SPDxOrFLA0+lcQV2oynI4XO
	n8YFRcReXF/PLcMNNaO/UcefU/MurhlMryvLgsTIXqMLQpoRr8NXdMieehy+UFpXM9E6/hLAVAT
	djDfvP1ANU5gvNTNTsQ9YDUcyydu7NFo9rgWOzRuvKAWum1Iv02pzPMJS76kTH8WJUrftRC0tcp
	I+9GmJ3zPZsoke7w==
X-Google-Smtp-Source: AGHT+IFka+mg1Yj9oEyyDd+jKWIEszLBRg9x40H+3xd41AjnTszbN2Gj1wk9UIoSwUXaoShKmeeJXQ==
X-Received: by 2002:a05:6a00:1ac6:b0:781:15d0:8840 with SMTP id d2e1a72fcca58-78115d0952fmr11226048b3a.7.1759160754625;
        Mon, 29 Sep 2025 08:45:54 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:2b82:239a:7350:ef6b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78103f1d1ecsm11434246b3a.90.2025.09.29.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:45:54 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: validate extent entries before caching in ext4_find_extent()
Date: Mon, 29 Sep 2025 21:15:48 +0530
Message-ID: <20250929154548.360371-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zhang Yi,

I've prepared v2 based on your feedback about avoiding redundant checks. 
After further analysis, I'm detecting the invalid INLINE_DATA + EXTENTS 
flag combination rather than just VERITY + INLINE_DATA, as this addresses 
the broader issue of mutually exclusive flags.

The v2 patch rejects any inode with both INLINE_DATA and EXTENTS flags set,
which catches this corruption and potentially other similar cases.

Thank you for guiding me to the root cause.

Best regards,
Deepanshu

