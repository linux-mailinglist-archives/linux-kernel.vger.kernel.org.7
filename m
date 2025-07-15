Return-Path: <linux-kernel+bounces-732509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59957B067D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30361AA6060
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2051B27280F;
	Tue, 15 Jul 2025 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="JeCulTPb"
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3772615
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611758; cv=pass; b=PZUgeUvQH43qmK1kkWeXKBGtnyq5kUlGqolOBEUhXpN7iPJlHM9ajaaBFHxjW4swG9/KfGe51ElWsKz0/BV76GjorkSs5atvJI86lX1AF+Azl8U0CEyhg9okVlFTuBugzWw7tKgmljHerwUHyY0CGdKsbfmJ89wu4J1Y5xG+yD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611758; c=relaxed/simple;
	bh=/EGplFmFdDaFIlxDjUp8+I5IOsGXx2jflQQ1nDBahLg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kn6JGsVT47iagOIds4FJsthe9YoD3u4VBhC6PHJEZ6yFmYXLLPVCgC6Rx+qqQy3vYJ4KmBetrMqLLskq3R+e446YXN/1rd5CuJK+fUOHEXymgTntuPGrdpJ3yShN6qefTX7CPRiZb7sgpm+qOi/X/kHrOCrsjW/weXhkajEiRz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=JeCulTPb; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1752611740; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GDJjWFDfW1vJ1KJF7yBcUwNgNCQFAUvIMO9SemxXqbga86IUwLdPeOrIBNI4v6pRkHtM8LIy40Nr46Nl7tg+CjTeohCbFi4YIhvotlmEIbp/+pZUZ3hlO6OiDeK/MIxUMsfI4gWfx4xSyu7ICFKtrC54nqCFFdKBheC97u/4/hg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752611740; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sg9cSog/t/C7MxTkxerRGoUzchkZtB9WA0zvkJJJ/Zo=; 
	b=WSbK8EHz6xWFbEcut50V9u7LTZxmliiKUKB/2gauJrZTWufmMjJTq1H9OvWycZ2EH2YDXyziLDcDGpJaMU/9YrKhIjN6lpGHym83mNrXoTuz5iqKmrCZ+adyCpcFCcMdB3UBTZS2xpTPHjcyl7yHLCGI/hpCuhjj2mdJUSHoG2w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752611740;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=sg9cSog/t/C7MxTkxerRGoUzchkZtB9WA0zvkJJJ/Zo=;
	b=JeCulTPbS4YKzRSGkVqWaNsB8rVuw2pby73Qsgz+UVsi52LN1HjlH3tTUvrSytYn
	LMHMfAPCNh8tl3z7nJP/7ANdpz7uSDe9vWCoIbMMnLQ4u1HRCmGn3WwM8HLGXkLOsnO
	57CICzRQhmwquvw6WwSZmSlOIxrvbroC8AxhsCTg=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1752611737365232.38019705711758; Tue, 15 Jul 2025 13:35:37 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Tue, 15 Jul 2025 13:35:37 -0700 (PDT)
Date: Wed, 16 Jul 2025 00:35:37 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Jocelyn Falempe" <jfalempe@redhat.com>
Cc: "ryasuoka" <ryasuoka@redhat.com>, "airlied" <airlied@gmail.com>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"kraxel" <kraxel@redhat.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
	"mripard" <mripard@kernel.org>, "simona" <simona@ffwll.ch>,
	"tzimmermann" <tzimmermann@suse.de>,
	"virtualization" <virtualization@lists.linux.dev>
Message-ID: <1980fcccefe.10a7c92b36705.2744765212931179004@zohomail.com>
In-Reply-To: <1961897d-cf42-4495-aec7-f4c20dfe7566@redhat.com>
References: <20250613132023.106946-1-ryasuoka@redhat.com>
 <20250714000456.14-1-safinaskar@zohomail.com> <1961897d-cf42-4495-aec7-f4c20dfe7566@redhat.com>
Subject: Re: [PATCH drm-next] drm/bochs: Add support for drm_panic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr080112275341d22ecfcfc54868533f56000088b215d2d476d17911edfdb24155f2b69b123163ceca421cc3:zu080112271e08d72822589c1ba2a422a30000446941fd3c8f2f1f8d69dca0f28d793e6fe8d7f37d6a1996f4:rf0801122b1ee2434f1540b8a76694f9370000d8052efa9f28df9d83271c92cb30b6fe6e834fd8c4b0247f5377572e2a:ZohoMail

 ---- On Tue, 15 Jul 2025 12:57:04 +0400  Jocelyn Falempe <jfalempe@redhat.com> wrote --- 
 > "Normal panics", is just the console logs through fbcon. The problem is 

Thank you for answer! Is this possible to configure system such that fbcon works normally,
VTs work normally (i. e. via framebuffer), but when panic happens, it is displayed via drm_panic? This seems to
be solution to the problem.

--
Askar Safin
https://types.pl/@safinaskar


