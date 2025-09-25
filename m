Return-Path: <linux-kernel+bounces-832316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF59B9EE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806353A7FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7DE2F7AA6;
	Thu, 25 Sep 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qwB1T7Jj"
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3520CCCA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799522; cv=none; b=cvYzxwTbjFQEmYKGsnX6LuXvEwvwlmP5ZvBZ5BLdhF1ro8X+foGmuCObaNLMAlESUUYfRc51/4WnyAmuTeLzT/Ou5uBf3Ebjop4QiWKr044c2np1s5HExK/Q7ejTcQqwzvN7dutBE+SLJMAWeYHnDxwEU09GCSOGJa0R41LXQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799522; c=relaxed/simple;
	bh=zaUR6ljnjhGuIR659lRlC1useJXQ5hQK5vZ1NU1k7tk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HIfwLfwQTDmt/0KfmeUTJf4YMdS8dx7K2pH7VDpSsJp8QNPz2xPm/9HR5s7qMYCWuBoZhnGn5lGY+9ALwAEH2NbzJDfxn+6gKTDvgOGmPXF5omJOLA/WME5u5dgmUyDl6llsMbk6bynIM8SGgCA5t4mp04oAbn2NNy7Hho8K1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=qwB1T7Jj; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758799503; x=1759058703;
	bh=zaUR6ljnjhGuIR659lRlC1useJXQ5hQK5vZ1NU1k7tk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qwB1T7JjcMXlaV/5vWrApRZV3FQkD5V9tkuS2a/00nPhhgWmucqXw2AiVOUDeh61h
	 8RXDSAMML5K6eBs/cRI8D4dg/vPzmP5J5eZd/I1csruEsvdzGOhAMecAr9auUBLerc
	 kzCyiFW8ieZtm17i56tMuaSOZ+SPAiRoz7gDmBH2Rpk90NQJdu0bwvNAVg3GNsCLPJ
	 oEeOw2y8hHZdJ/1+/syovH8VnAT+gsH1c77BaToYGggheMjsbkyMJ3Yf6NE0EUVLFy
	 InmunO/Fx7kjyl1Gfy4AokHKRHui2537nprLDniqeERHIko4J0GT/1Ie3NUDPCGf3w
	 HnGuTqxo/4O4A==
Date: Thu, 25 Sep 2025 11:25:00 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "??\"ceo@teo-en-ming-corp.com\"" <ceo@teo-en-ming-corp.com>
Subject: Bytedance Proposes "Parker" For Linux: Multiple Kernels Running Simultaneously
Message-ID: <9LJwyFyXgbo4ljqoG9DElKaNLFMH4zbJiXu6dWGyIymJUwq3YitedSFBPUQmvQDNSPTFBPAMDiwwCyIypiTAM3O1rN1HyxQn-zH3shuVOPM=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 68cfd1b4122dc0ee9fc9c0d118fdb2166b64e1f8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Bytedance Proposes "Parker" For Linux: Multiple Kernels Running Si=
multaneously

Good day from Singapore,

Here=E2=80=99s a news article I=E2=80=99d like to share.

Article: Bytedance Proposes "Parker" For Linux: Multiple Kernels Running Si=
multaneously
Link: https://www.phoronix.com/news/Linux-Parker-Proposal
Date of article: 23 Sep 2025

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals Singapore
GIMP =3D Government-Induced Medical / Mental Problems
25 Sep 2025 Thursday 7.24 PM Singapore Time






