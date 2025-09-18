Return-Path: <linux-kernel+bounces-822879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFB2B84DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B516754690C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46F430B52A;
	Thu, 18 Sep 2025 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv6Ud6BJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E30308F3B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202574; cv=none; b=WnRGHd22i7XgPnUe0yuwAbtiaeaHZXRbaafh/D2LhlmyY1+piSqeGrpsoj22wjoB2UaCBHFIoBbqV07kmEPDku0AUK0U5TKrAu+Wjj3xK2VmNMIgoYR0cgSDqkvTvI1feRTNWDpK1i5g3Dq7lK+2Folnk5uiTleHWBJwGHSjhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202574; c=relaxed/simple;
	bh=0M7WLWX/5EE+SdlhyLs0/U1VYk0lza2pagmteJhuzJU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gZuORtKkkWGoKEJjU5aqBe3ZfIPtaocdcI4ymFo/XZaDkj6uqytZgpovXKD0Kcxqp3W+EkWzMjTD9f8yR39IopiGkozwGqMhDRHAvFDc8djEjG40vQpHRmtO/9wFEajqkQWlpBx7qKDMJycmmA5Za2EO9b0LrlMz1WttLK8d1ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bv6Ud6BJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758202571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0M7WLWX/5EE+SdlhyLs0/U1VYk0lza2pagmteJhuzJU=;
	b=bv6Ud6BJggoXO0oZ0ipXpmj9hlwkycCf3AS+bv+LqPFbw7YzXk8yZJdCQCGsAH/0iiOByY
	5GVpkFlK7iS5BKRdEzEEiFG8b7zXaGKYKxgDF6XwAQTpEebxOJPrek5IMqFcBbJjCumnIh
	lmEkL+iHtCGlscnDdyc2yoyVj2TmPow=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-JCEhy16EN2SGQzOkbBbwxQ-1; Thu, 18 Sep 2025 09:36:10 -0400
X-MC-Unique: JCEhy16EN2SGQzOkbBbwxQ-1
X-Mimecast-MFC-AGG-ID: JCEhy16EN2SGQzOkbBbwxQ_1758202566
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f29c99f99so5901875e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202565; x=1758807365;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0M7WLWX/5EE+SdlhyLs0/U1VYk0lza2pagmteJhuzJU=;
        b=V5d78xXHU/kZkuCD3fficfQm0RS0pIlTndgIlYDJ4s74XifhDLGaeCKUM9nvZUxay3
         TW/AMcWXkbPrExgPngCSLs60Jb9TTimGf5s9dcgMOt8V5GSYQ4IAHQzISME9iKRDoeQY
         7cOc7IXwRDin5a+9MMNd1RRLsDVvq1IFhhojognlUN3r+ii88jrU6gKI9BbRZXWOamPk
         tFSDic6THCRHljDDFDlw3JTc8/wcy7ni8H3XR0LfuoXMrvsjGyo18gTc4d5D+Mra19IV
         wTpKCCoN8jRwiK7pXKJBk0Y+g3yAOAdQ2gJg+GnLD3jHTCBUVzbGXLoGrt4O6dMBZ3kZ
         6gJA==
X-Gm-Message-State: AOJu0YzO2Pn7a9E9du8exkAg21gHhCHPVWBHW0cXf4S2LuSnDIB2j1pY
	WIe4uJjYvwGX4uTeasDBw4mYQPdptSxsI+cTrXPJjN4c8w9yubqYBJgE8fDuqB1AUEpikaApwg1
	cDDJVJfeYsbT9S9zkOdGaXLYccZi5IegrxoMJl0tY+wFV/4nD5Ly5ucAVYwOaktuHaqHM2xlsVI
	rVp0ZyA3vn8BtwsBv4diY7KMhCLsQO206cUXIwPz03ZNbKhynXtQ0=
X-Gm-Gg: ASbGnctB2wyGvPwFbc7aqOdXvVAHL79vEN/wI9I3c2zVXgyC9s5H9MNHTrYG98Q2LU3
	GHok9GpAu7M+7hCSV0DJ9CFXnf6ppF7POf/UJkSfFSkPOIvXSlmi/+K6mcNzeHsHQLJXivUJIz0
	JLb0ElVnjGzaVZohFxL6RLTA==
X-Received: by 2002:a05:600c:3151:b0:45b:97e0:22ad with SMTP id 5b1f17b1804b1-46205adf7a4mr62102465e9.24.1758202565656;
        Thu, 18 Sep 2025 06:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK40c/PFVUox7yvTpi4IEsvf1eOhq81OBkIMw1SI3tarrPudCW7tXS1Ihu+XEI94uMZuWFxT1Ug6EIEBr2+3M=
X-Received: by 2002:a05:600c:3151:b0:45b:97e0:22ad with SMTP id
 5b1f17b1804b1-46205adf7a4mr62102205e9.24.1758202565231; Thu, 18 Sep 2025
 06:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luke Yang <luyang@redhat.com>
Date: Thu, 18 Sep 2025 09:35:53 -0400
X-Gm-Features: AS18NWBBubMyaY4AcIyRJZ_oC9_DbJViFfcf189Z3689EW5Z9EP4Ye7lcXvCPRY
Message-ID: <CAL2CeByLWBf861qdkxt1TD6qpUiuxe7s0XK5C_1C_wkCX9V9cQ@mail.gmail.com>
Subject: Performance Regression in Futexbench (mm-test) from 6.16.0-0.rc1.17.eln148.x86_64
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>, 
	Nico Pache <npache@redhat.com>, Jirka Hladky <jhladky@redhat.com>, Jiri Vozar <jvozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

We've found a performance drop in futexbench from the mm-test
(https://github.com/gormanm/mmtests) of ~30%. We can provide more
detailed results if needed.

In our version of the upstream kernel, the performance drop can be
seen in 6.16.0-0.rc1.17.eln148 and subsequent kernels. Multiple
architectures are affected by this performance drop.

We suspect that the degradation may be caused by one of these two patches:

http://kerneloscope.usersys.redhat.com/commit/dfb36e4a8db0cd56f92d4cb445f54e85a9b40897/
http://kerneloscope.usersys.redhat.com/commit/56180dd20c19e5b0fa34822997a9ac66b517e7b3/

Luke Yang


