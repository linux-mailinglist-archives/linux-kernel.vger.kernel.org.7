Return-Path: <linux-kernel+bounces-760727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8309B1EF53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7353B4DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37368222564;
	Fri,  8 Aug 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eXkHHbCz"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2941F2BBB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684290; cv=none; b=ZuTnqNyWmBVXNhhpurWQrpjzYI18jlJ6jMZN4K8KUJ4BDdervJJq4VHj4H31MRbeCbJe4LFPOtYFL0sDYyABsEWQ5RX//w9m5C9tjYA63jaXNloyS26aF62WlB/k1wRTVt0C5sYSH2iR3vxuL8ElfplyJaoNlNJr7Ru4L941ulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684290; c=relaxed/simple;
	bh=3w+S8z7rt5VTuSffcO9k7jLwrJH3C6Bell4uHGGUd4g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mj6pdqKp7MtsDM/vXhCexsBs3ZYnkB4+z8X28nX942VNGgtU+yQtmzs8chKXwzwg68iuEbInmP2lOrvzlBX3AcJAyNd1Qp0B+pnEkyABKbjROEF1it8eGQfu99poq4rgJOAWNvX50RmVs74ZuHiLJgau3s75wbQZWofsjDhD/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=eXkHHbCz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b07cd5019eso28133791cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754684288; x=1755289088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl43cLtacEaHV/RWtjYcg0CuQlsW0JyoL1eQ6Ei05H4=;
        b=eXkHHbCzvbNn5cMdqJpWR9816GMQ3/hZplALJ0nccTfsgczYzfIgZ8SIIcXtS4ba2W
         f/NMfjlliKpqewtwOflKQKpyGmA6dDTzMbbxZ4HeOXx+Wwp6JsixqM34yC2h6nhabynb
         dcTPT/nIP2dIerywK4K5wLCDRwQ0XQZ9nSB+gXAmahi9qawJVK2OEkV9CkEjHfiy3R3N
         vvYvMPJD8Plbm+7xpWoTC0AsNkDi5uOhAy+pzxpGo9DsPieQX4w3+aaVOGW073f6aai1
         +y+nJNW5SGeXaGJBLMTeO5TWiSG/JffqM/5i+inucRmoA0YlBtX6QVBMRSyHj2vG9QW2
         fqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684288; x=1755289088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl43cLtacEaHV/RWtjYcg0CuQlsW0JyoL1eQ6Ei05H4=;
        b=faWsWefr0fAPec7uisXmlXssDe+psSnMX4nhKU8jSSX0mbBczQmQjag5gFvy8BSSzP
         ivOGZiqWSTqTFC3471ahW2uzWd2nxUbtOYUa1EDsBKJQ2YPD/cSI3n94dH8gYZREmL8a
         T/SD7SY+oH/xZBvKg80U/REI78SUunme2n1kmPi34aPpv77dVJdyCWRI1e3j1P/6FTTS
         CUwKyDUqH1Ok+BDkr/G8/XPTaDJ8L/MPl7MCOeBKHhCy9pC1szsGYS5qubADmGj/2ESK
         nyjvR8mpkZMmCuzYdCcjzoFPQUE+pTUXB2voT4h8BR0PCdlMVvHA9Fg9BF7ChrmHbZ6Y
         X+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRh1RxDeKUKIyqeiwFh91TTETfSZ+Z6w14Nv4EoMgKAzUUL/7M6lE1rD1Wh39OV/xXWIsBZZ8h0RsgXuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE20dlR/jxtwFibAoUNyrJkMYZWTtlxsXZMHRl4uO3hfHwIC6m
	wx2EcZ3yhrqs2n2ccbTU+lOPqZvATEM3xwNHpwTstczJURMaXuST9gf26hW3cTDcVDo=
X-Gm-Gg: ASbGnctirfT8qOrbfRAw34+ToBwWkkIzXs6XgQaZzdnfYaHz/kdeCcqoDMfPbQfgP6Z
	HA+PPMyp1H8HdwN+e7HabKtOwhK+dZPjPKLZyCa6JurG7l3G3CiA2jctoycp4IhflVXEN9hWrUI
	VNbqE4lC6+3UTIMieV81PrsThHJhlpCNtL6eVxawFsKaq67x6zkJlt3OHE1xWnlECwYpGUWe8HL
	/RRkYU1Scb8z4pvNNSNT3h9BYr/lvxH1QdA3fB/UasjTTTdX4aoXFyKvFPKGb46ZYWevE2kqlP+
	sIEfbTyTZdeGf+NOGvj0A4uYZBYAnmj1+o3oGj2okiU1hya6705u6uB7au0JU2bi58uaXa1g0Kx
	90ZrTUsx71aGBwsdCx2qx3GtNXreYDOuzTjaknSiYPxFAsH85PeAA+kATLorw1Buznh2+cQfhtX
	N3tOd9VEdFrFV3
X-Google-Smtp-Source: AGHT+IEkycL5/Killw0PruH454l+HlYFvVCGLaFuncloU9u/TMGcBjOQJHVOoRlOgjZJOfGNFrwDZw==
X-Received: by 2002:ac8:6f1a:0:b0:4ab:cf30:1892 with SMTP id d75a77b69052e-4b0aec7c47amr80830561cf.22.1754684288169;
        Fri, 08 Aug 2025 13:18:08 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07c80ddbbsm59490131cf.57.2025.08.08.13.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:18:07 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/3] Several KHO Hotfixes
Date: Fri,  8 Aug 2025 20:18:01 +0000
Message-ID: <20250808201804.772010-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These fixes are taken out from: LUO v3 patch series:
https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@soleen.com

Pasha Tatashin (3):
  kho: init new_physxa->phys_bits to fix lockdep
  kho: mm: Don't allow deferred struct page with KHO
  kho: warn if KHO is disabled due to an error

 kernel/Kconfig.kexec    |  1 +
 kernel/kexec_handover.c | 29 +++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.50.1.703.g449372360f-goog


