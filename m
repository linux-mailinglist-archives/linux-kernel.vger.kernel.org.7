Return-Path: <linux-kernel+bounces-846410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BBFBC7ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2AA189D241
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2749F2D979F;
	Thu,  9 Oct 2025 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA+JXcM2"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F32D94B5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996980; cv=none; b=t3RtOh2YGUH4PEZ3zP/A3/xhAF0LdRoC8LEcTgV2WAEZ+JFIwthNniSyMKhDwV/aoiLiUmgu0StO4eLC1BsoHJRLPMzhmmTOxOh8CoLqRtVT1rS5PtB99xATXuHpVBemoh0rDG77gZGiR5LRIrap0c4cDWuiT9Jjl8wPnoltvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996980; c=relaxed/simple;
	bh=K8tOls+YuUMbAJn57FpEQBFXdO/h3ArpWBRwCguKFNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=to2QZuOyaKxVYRkwnU8hQj3FVDHC3aOu1mrIKSNghQvHmWQBXavn44nRWAAxHsZABNMILWP5MbIhGfHFKBwdaj9oxrYwUYs5AspOSrqVnJYHeJWqVvILCMZ3wAQj7kvwOwtp7lNnrVkqz3YDzQHw4SbxmPaUgPLWCN/gS9oJCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA+JXcM2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4256866958bso381821f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996977; x=1760601777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmgZ1stJzO0OXNGhzzc20pBZnkzJWTSFXL/OwU1NfN0=;
        b=LA+JXcM2mnYBvjJQEJrG8uS3chyIqiTX1MTRFTFHaqiNMTJvdKu28M9xmaP5lwt5l/
         +7ZktW0TZcINRV7ljlJkuMJcCvepFrvusrsnbaLX9u8ZJGLGpSZe5syKkovR/HA1scVp
         jNVGQcOvO2exIYe7sNDzJpG1gumKUFs9RO9cHc1S/R+N5Syp73Dz6eXYcT0aGaF3i9lF
         KBIZwN29vudkMFSFjSVKzEudy157ipCWnWun1fY90eF8mGlE9xCqwt7bYMnE3iQbVq57
         Z6u+Vg9efOCBOLOt3R3N+c73X05l3hh0mDxsPzvsirlt5TYjme5WRAetj8mgicpHN5Eg
         KvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996977; x=1760601777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmgZ1stJzO0OXNGhzzc20pBZnkzJWTSFXL/OwU1NfN0=;
        b=bNEZb+WNJBCY1K/SYsPXj1EGKGq3I+bVS3tmhLDQXVRUdz75ppRp1OzSUvxgm4OMAZ
         HgM3dszc8Jl2z2zgVBUepE8srFbETjvUE5SFPyLLw85/OT/+DSK2iHRCRWEEU6NP3YJL
         gS3yL/IxKIVIBYNyvdfWOnzcG8Q3GgR99Qk8A/3BCPd8JWArWLV2vkoQwl7i0Kmd1Nrd
         0RBgCULFJkH4CrH+2zxdhAJ9VEH1AqE/OC3BhAlvttqm9ffl8l+hdDW/5WwhX2PDShpX
         xhlgipVZj/Eu4kMMhReGhNNrPT7cwqXBOPyi7SB2bVHvy+Pxzq1oagcvSWpJUwoSCc4g
         USWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQZaJ63FxrVqc4cu9LQesAKXbXE+HirWSMi4RKb+YCt8wsBN6J3xMYCqNd+NEQG3gh4nZ+V3hMs6J6hqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweM/gNJBCod4Y+/pNa8mWZG3Udhl1os6No5OXGK8rkjEpXgVeg
	3yYAiY0fqAEUZaXWdfh06+ahFLTWlMbOYwO5gF3o5++Zq1V1uF+qTTwn
X-Gm-Gg: ASbGncseIFRYXoje7tSXQ9f537Bi/8oPyrRMytgSel34YyOEkQWdRjJX+8IKrtMvDvr
	gKbe6aJl6DGZbiu8OKDTYYuAERcVHpSJna16DvAy8oIrdJbTfXMrsPwRljDz6bjTdxFxHzHpoF+
	mClD/HiNW4ii8wIvbGQS6TxPwAj4SCkrN9AWqbybLRbMqFYJ/FfWGvl1tFeZcPerXd4pwW0YJRS
	bu+3Vfltu3AVDJboLB2jpGyKrrKy6qKle15Xm5L/TkzlqVcHyMP2AUUXKqmJQciidgOZrqaAkCT
	y3qwhAs9BmVDAVoy3PBZQVJsTprZUqtZIMjGfuy5ztZX0Nhp35U8Po71VFAfmfdq/eyIRAVQw8Q
	xVyGMmlUeZ+eWOSdTLML+bi9jYBIb2n8PH6ksRbC0p+A=
X-Google-Smtp-Source: AGHT+IGzzMQT0+Q4KC5cr5OVvpL7nF2Kx6VgeouWeY1dugB8ebtVbkbcg1MO5oNHGLNrWpLIfhYvqw==
X-Received: by 2002:a05:6000:430b:b0:3f0:4365:1d36 with SMTP id ffacd0b85a97d-42666ac9d80mr4139943f8f.16.1759996977400;
        Thu, 09 Oct 2025 01:02:57 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8e96e0sm33432337f8f.33.2025.10.09.01.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 01:02:57 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-kbuild@vger.kernel.org,
	regressions@lists.linux.dev
Cc: dxu@dxuuu.xyz,
	linux-kernel@vger.kernel.org,
	masahiroy@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	nathan@kernel.org,
	nsc@kernel.org,
	ojeda@kernel.org,
	sam@gentoo.org,
	thomas.weissschuh@linutronix.de
Subject: Re: [REGRESSION][BISECTED] kbuild: CFLAGS=-w no longer works
Date: Thu,  9 Oct 2025 11:02:50 +0300
Message-ID: <20251009080250.1089826-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009075149.1083040-1-safinaskar@gmail.com>
References: <20251009075149.1083040-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug still reproducible with current kbuild-next (2ea77fca84f07849aa995271271340d262d0c2e9)

-- 
Askar Safin

