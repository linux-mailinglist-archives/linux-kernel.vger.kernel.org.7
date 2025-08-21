Return-Path: <linux-kernel+bounces-780337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB6AB3009C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9C17B5B85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498452E719C;
	Thu, 21 Aug 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AKYJcttA"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB92E7192
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795536; cv=none; b=Ur42Z1e5RiFc+OM/wy06wxrlDhh6ei+WThtsWdsCjVPXh5fWZSi5kp2eqf0XbbLJcZ13R5LB5ppIAPCMle8v9y3iEhKDq6RZdeoopV5lIf91J0Zc9EkQlyLolI8REU27WCZjVUpY8B6+rDycgDob56xNQkHWAtf086UbCrbITe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795536; c=relaxed/simple;
	bh=3A4U0mFlnkILhub4vGFum/rHOWkZrlTYW603OLEkJVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqSq9snyLaZBgrRSMttqwqWYgAIFB0EQ/tOK3psAd0QfUhj93MFZHcGzgYNv5IuKXMZn+IZLKblF+e0qHSh8N9AAXogZ5Kov+Q7V/j7BQJR7k9+ftACk8MyLqIBO24+0S/bs13LI54rKer2gVXX3nufCOIdOzvRqq5hhc/SBD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AKYJcttA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b5b7c72so1956427a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755795533; x=1756400333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A4U0mFlnkILhub4vGFum/rHOWkZrlTYW603OLEkJVY=;
        b=AKYJcttA/ghZKZYC7tZBkFM0Mb2/EgCjLiCsho3sVE1N0zQlOUuY23ZAdao0V3gQN+
         9bsm8X7d/L0hK6WIDN6Q7JT4qGdMAlNSbC4PrBkk2o//JNflnpbNE6uLpwPORZZJ2WkY
         sZfonTzb7tqKst2ugQrihXHJpDuRGh4bCcGSQ5OvKyLOP0Puz+TmiUU+SESdROqDEE74
         4skQxgs8BJJ/VyO/18R4Hk/Kzc3XXQHtbY6g2AZQmSihSYNMOv6iUPm2j4vWbD29Fh2z
         5bVC0iFxZZYfQAUlio6uwk99op7mmkdITWEJGzXYeLAHqYLk3dY0emEHOQaL3xzXyAXM
         FcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755795533; x=1756400333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A4U0mFlnkILhub4vGFum/rHOWkZrlTYW603OLEkJVY=;
        b=bDzEnOOiqGSRdGuVvGDW74Qbn8ulDYPcpm1E0S60AlUz6eVrh5Q5gDKfpekLxF3gay
         JOWuQWuN7F5pQ0kvzZc20XoQHMdftmUzRzoywR3HvrH7nhrVJJCUbJbOkpa4W9ELJ3vy
         10By0UQX+d0okA/g4fkc5rnDwLMGTevKBOjdbXRoXF2j8251/p/3hVsdbEhIyhDDWC9g
         yo9QUyNk5yJV7Z9QRIc9P9BCtbxoqd+k3ZjJMlHQsC28Sq2lSoaGAtEw5egurBDsXaQf
         ESENLiht7F1+3BT412xx+BTbVgvAAFsB/Klc49XRgmRDMttdFRsyASEq0xpfdckwd9/v
         Z8pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC94XNvLvg7IJMqeUXOS56fxJuGsX/QwmomUDLeBDOxDa4T8DusSo6De+ZPHlo6NwGkGzAMjLxZufbZiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyYaXXLDJbWeQEwlhbJxPSKJS5frZSyTynvtq9GSzWYJ1cOtH
	Rvr9zXNAMZKNGJ/pzF6t5FxnHbKtyiPQq9u822SkDNSC/+m3xMkyi4Wiif1uHloCBT0=
X-Gm-Gg: ASbGncsztrWkVK6lWEOA7D+aH+Yf/XxbaxTRPdvFFxBZuFX3ARlyrMLD3g3PBp3WoBT
	CDnJpC2CBiv63bBsDGc1mGvIyNxBm+q/s2SECAMymu6pbqedhUzjNjcExkMAmwQfX7ujA03mcYm
	QyrHipygHbN/K5QAdXfthqx8N7x+YtzAE/14k/5CCzKPOw9Oj+4MhZO/9/j8huueZAhk9VYqq69
	ZJjf04ab+HWiCdyGzdkjegwHuzrVTFbnoDTrULos2LSBMVfshYdnW1j7iS9xPAoD4aCAdJXZont
	Tik10CQY5aqcPJto/X+uy1CssW4E1+8YH6NZHVv3PU3CY4RpjHnJkWcZ6q93TVnxASql2miAx+c
	fs1dMIxwECLZgUdf7Bwke3AVVghbR+AjcWiMk2d1Wi6D5VHuU
X-Google-Smtp-Source: AGHT+IHbD3hrlfzfuV9dgz0//kT04PlITNsV9cNrzMXodwD/dQM9X/pgqOr/RoZqgWohk3JzCKOHjg==
X-Received: by 2002:a05:6402:5057:b0:618:6fef:83e9 with SMTP id 4fb4d7f45d1cf-61bf8743d4cmr3099366a12.34.1755795533295;
        Thu, 21 Aug 2025 09:58:53 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61a758ba909sm5450122a12.54.2025.08.21.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:58:51 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: zhenzhong.duan@intel.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
	adam.c.preble@intel.com,
	alison.schofield@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	chao.p.peng@intel.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	helgaas@kernel.org,
	ira.weiny@intel.com,
	james.morse@arm.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	qingshun.wang@linux.intel.com,
	rafael@kernel.org,
	rrichter@amd.com,
	sathyanarayanan.kuppuswamy@intel.com,
	tony.luck@intel.com,
	vishal.l.verma@intel.com,
	yudong.wang@intel.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	ashishk@purestorage.com,
	rhan@purestorage.com,
	jrangi@purestorage.com,
	agovindjee@purestorage.com,
	bamstadt@purestorage.com
Subject: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Date: Thu, 21 Aug 2025 10:58:29 -0600
Message-ID: <20250821165829.3471-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <SJ0PR11MB67441DAC71325558C8881EEF92A62@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <SJ0PR11MB67441DAC71325558C8881EEF92A62@SJ0PR11MB6744.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello. My team had independently started to make a change similar to this
before realizing that someone had already taken a stab at it. It is highly
desirable in my mind to have an improved handling of Advisory Errors in
the upstream kernel. Is there anything we can do to help move this effort
along? Perhaps testing? We have a decent variety of system configurations &
are able to inject various kinds of errors via special devices/commands etc.

Thanks,
-Matt

