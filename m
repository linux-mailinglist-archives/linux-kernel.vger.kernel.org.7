Return-Path: <linux-kernel+bounces-738729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3870FB0BC60
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C177179B46
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A3821FF23;
	Mon, 21 Jul 2025 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjGODKQt"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890E21D3CD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078468; cv=none; b=HiBkFX/AwkFmaWl7V51rdV4cZgW3Nsl2uiQRsWHn2roxZXQg1wapmKeCx1SP7WJ+rQ8TO433qch2SUm4Pb4g8rR8aP3t4i8wQBWy6vKTOD5NLRa4rVFjHVTiDN3bjs/I/3SNtZ/WQwYj+Hg6lCvVVRMJVmkkZ27qKMImPPU9304=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078468; c=relaxed/simple;
	bh=SjzPu7li/w++7SuHXLHXUxL28Hj/1zgWJ2+9pgGwAOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZH2a0mTMFFiugp1Bwp2d0i6iDuWRA/OgsmvmtkR0jw1td31lqr7Z4YAqGS//1dSVYspmC9die1iWTP/GN0jnFZKt5RqIlDtdrWrpMec7neC89comtsKD9JpeZNNyCWP7lyNvTplJ/qSpXReVSEixfOaiDGlvIPNn1l0p4aP658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjGODKQt; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e278d8345aso395428885a.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 23:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753078465; x=1753683265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUrJjxdlJkuWAxks6dZw4thmAFt0XlgLRPKiCZOnDHs=;
        b=GjGODKQtudCy47AOHCcRMNNVDpyMhA9GujOf+hWrGVJ8pa6RHrUfhGQ9YOdmI7mYlQ
         CLKdtNkkyOV6uWt455UVstYfchIAKstygw0hhUKgEltohy8KV5pXZsM+co3EULwn6vCz
         nZ4sAf92/W03X6OLUrEp2KTyshTSH21/qE1iOkCw3ocF9OfmVArK7jGqZU4nCXjitvmF
         YJDpTmq30ug3JyJ7Mqa1beWPUuji3DyOrv9XjEpgML/oCNVdkyNVXyr/dOZla7KIYq5q
         c8N/31x+fuN9n1V6uwjBFD7NA6arcxJd8VcK7d17zY3n1UhCEm63Ko6nvSH05QbTfSEb
         9Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753078465; x=1753683265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUrJjxdlJkuWAxks6dZw4thmAFt0XlgLRPKiCZOnDHs=;
        b=UwH17E5Fi2Q3qb+TJYU3+05QMGQ4hnQN+eE2iQDSi4MYKBuHJcXgOJPJ5Vfpnh/ImU
         K1ZrlNKRoL/fV6uuN/cMA7DmxEcXjyDAKVUuj9GpzbibjtUZPQS9uf5eHT/HYlUnFLQh
         zCUC3QC1b2G555OHm/d0d2xeGeAqtINIE0XhOw3rXK65EYST7oafUgVGMDdondeHcJT5
         MYD3tFEqo+vBUCTlfsVTDVcxaNlfj59GZDJ1Dz/KyQ9IUmBo4cFqqbO6JfNTrg2Lb6yg
         NRwWfbs/R4fyPRwC0Fo14ckcHJHQAknOfQQgRGPJm2AXXQmnaHB4eFIun5tU7mwQEVGI
         u0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWKOIBxs0HZkwUXF1VoPbOCDIwi4a7H9Ro8zuefwRudCyvI2kVqGCyY2AAUvgJ9O6hoBnotKG8hZ9+Eo9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXwfnNZBoM3kcZdmlZA1C9P3IlX9Ax4TYMKAN3bfCEka4A1l5
	tflrwRAnkr6gGABpjYFtN0xPTUPm2BtBWI1FJvZdhQsS+RhbWF7JrISK
X-Gm-Gg: ASbGncsIfG3jdA6qlCm81O6mUuUJf750SbeoclTpDXxLfvoGfU/OPKLwuEw+uU2qOII
	ThqXuJ5DQHMscib7p6nvBd34sYthuG1At7OPN16qrhUT8aOcbNvwOGyCSwijTYdt2WLL39EEBL5
	OTIg2vaio9LF+xXJW8nDfR1X2SArVlk+fHTepS8DTJUvprLf8L7PN1YoG51wkkPl+jnotXiswlj
	zdhM5j58p700OCmqmKvruVo3SXnfI/mG2TvCM4VkA8Bqkl8DEjy4NlEf71R1Z31wXruqgflsTJU
	fTCkyHtfHxcKqbLGuQKv8YALg6Mqcx+MVRkzDLfxXJ2+dsCj5P3Mr/nLbclSPnfx0BXK1T4vgfZ
	g/TZt3jutt+PXR/eTzf5Wt2OJDNphBd0r5E0b3auZeqbehNU5XYSY1VLB1qvXoQ==
X-Google-Smtp-Source: AGHT+IFV7evOdBXehEGbcmPmJL5cgVgd/HztZtKye5eZOfaD+ktrMiMzzud3BxNWK8s3itPM1PBBJw==
X-Received: by 2002:a05:620a:191f:b0:7e3:3604:5047 with SMTP id af79cd13be357-7e3436156a6mr1965809785a.38.1753078465256;
        Sun, 20 Jul 2025 23:14:25 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c3e36fsm379185485a.66.2025.07.20.23.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 23:14:24 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: vivek.balachandhar@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8723bs: clean up redundant & parentheses
Date: Mon, 21 Jul 2025 06:14:12 +0000
Message-Id: <20250721061412.297554-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720092125.246844-1-vivek.balachandhar@gmail.com>
References: <20250720092125.246844-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Thanks again for your earlier feedback on the patch cleanup for rtw_mlme.c.

Since the original version included multiple checkpatch.pl fixes 
(like spacing and formatting) and you suggested breaking them up by type, 

I wanted to ask:

For the remaining cleanups (e.g., spacing issues), should I submit them as:

separate standalone patches, or

as new versions (v2, v3, etc.) building on the current patch?

Just wanted to be sure I follow the preferred approach.

Thanks for your guidance!

Best 
Vivek

