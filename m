Return-Path: <linux-kernel+bounces-793334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FBEB3D204
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481313A65CD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181C246BC1;
	Sun, 31 Aug 2025 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvQfSFqk"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC43595D
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756635136; cv=none; b=TsiXzqFIyJMV6uE0/X5XFK9RrGBF4BePQq2xAQTwTEn+sRpRNN5yV8smprxbYeGMSQwYeIyIiLZMQg/ZCYRafiST020wmyrrcAG8d1HEudDkP3DgZ9lhrE9wg+7SU53QskTbhN59vc9ykoy7ycxz3FNtctdMf/RZrK3mJFs1CvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756635136; c=relaxed/simple;
	bh=Y+QE5ju7q026mUNUHObMI1mUISo66ZfzICcWPSRPWc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q959k9YQZkgLzRoNfvZOsUJTtvCLoQz3mT6Y72go07b8g1iZ9jlSKCHF0R40yjwGvaWReYN5Fu4JNG90eQAvVPOtgOmR4K1M1lbunZGLV7IGlkcu+mk9diD1PVCla5uO7C+GvczOnMHk1i5qXhEEtfGmD01AHFH2GgH1v4n8umM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvQfSFqk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7f7e89e4b37so332694885a.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 03:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756635134; x=1757239934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NnFF/qZEQ0vbIO+TxuJcxC4FDAmdCshCuApcWT/PwxM=;
        b=PvQfSFqkFxxeP7536AThe5PhD8QlTLGT5nS/bQD8IjBYleN27N1Nssg3QAS8WP7KPe
         pip5N0KCGsZdDBV8BOBfQFoxm+mcZUQmM0TnikHYhGE/savdhMxjbvDDZJoEyKiXgndR
         doUa3td4OqTdbNepqVI040fvfZH45CksnOs7fqP1lxbbb8X5dwJLW4nLyyRScMkPfAWy
         syK55YLR/tDhFBKhsaSu60zPuxcJTzoS3NkpD/JeRsVaZl1+ljvDALpjmB+aqUr3twE0
         Dxx1EAxZWpwemAXL35HZRDpK0qNjMEx3yXYWJUusmXhWjIZ6/dE+kT0FZ591Iy6zUwID
         4RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756635134; x=1757239934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnFF/qZEQ0vbIO+TxuJcxC4FDAmdCshCuApcWT/PwxM=;
        b=lD34rn1UdaWxybKnLozYicgNA6p3tNbK5kVwaG5DiugK3lH6DXsqsCOcw5nXlskVnU
         3ZRRHLt6BQ5exS3dfshkrvASCNwaw3GyA736YnF9cE/vk3wnyOzqL6BrAQtiGRYRVk+L
         qNDNlKKPZTKRZet7ELP6wCx9NIQBhsqAByFTTrspgcToL1c8LfbpINWIaRobO2rFI2RW
         YTfCNnDaU2ZTgnKEtW9cvAkGwhBpgarocDYxFd/uR+54g7HVCBvywrcHECeq1bTzQIK2
         gm0LhTFi7xHGrXMviNo5I0lJtBMD6Zxov4Nf9cfDQo33dM676YB4ZfN9GgPGK110h0Wo
         X55Q==
X-Gm-Message-State: AOJu0YyI8b4ibgEdOIbIJmbvjXH2R3ug0gxRlsb6CHR4aM7LMlyInhbV
	cZntwlZgJ0vyNx/FcjFB2uqrfvgSc/11iSY13wcWPx8lqIuY+p/tU0awJimBw8VoKpY=
X-Gm-Gg: ASbGncur9BmgcXc1LeXOO0/I+QN/VxQEumEKzZwAjhaEn4eWAPilGIgctbro7wky7Yi
	xY21beyP38iRA0le8vEfchaO1NbO7iLVRNX0v6hOXvRBze1Rh75IIeae3MdWrZ4oB9o2IFApChW
	WqvHBkPiFKaATgX4kKdZV3oFaaI68nCmmmAtPCy7SlBqPqM3AowbEJlfxk9RH5ge6E/F1qR1dTZ
	Odggc7wKXe9tOC7xjuIQvjOeUCb9l9ccX6FTAFOQZ6iKKWTT4v/I7eTl696CIlXnCb9vzK6hGW2
	m8hjoZyUzCRW8MPglyL3JmEGFMMSxfji2BGgB4AbZMv8klRKy43gpm/pjHho1btT84hOO0FsgGY
	/phwc2YNs8zE54panKP640JS6aAps6D4QXBk3egNwpxBnTUZtiNf+uH03ketVVinXWPNaWJdDSG
	borw==
X-Google-Smtp-Source: AGHT+IFUBsQ7kNw/ak4alm8uN4s0hWak+O6wVqJk1tUKchS/DIOKW5fL753j7a+PByQONpYuKL1Mig==
X-Received: by 2002:a05:620a:191f:b0:802:98a6:7360 with SMTP id af79cd13be357-80298a681a0mr37689185a.53.1756635134332;
        Sun, 31 Aug 2025 03:12:14 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:1bcc:1b67:3f57:d21e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0d773921sm492508085a.13.2025.08.31.03.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 03:12:13 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: seokwoo.chung130@gmail.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] trace: minor documentation fixes for clarity and
Date: Sun, 31 Aug 2025 19:12:08 +0900
Message-ID: <20250831101210.11181-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This short series cleans up two small wording issues in the tracing docs to
improve readability. There are no functional changes.

Ryan Chung (2):
  trace: rephrase for clearer documentation
  trace: fix grammar error in debugging.rst

 Documentation/trace/boottime-trace.rst | 2 +-
 Documentation/trace/debugging.rst      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0


