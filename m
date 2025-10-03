Return-Path: <linux-kernel+bounces-841410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50039BB73A1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A8CF4E5234
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EAF1F63CD;
	Fri,  3 Oct 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VEMOfIHc"
Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A039FD9
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502702; cv=none; b=HFmLFLahXQAlpVp5HjzxKIa18uprCeTODkI4IwWU7ofv0U9JQYpMmRvTiWoZNC5XCMd4ZJPRTgxtkr4+BJUjmcd14lfPXeIgv75JnD7ZXPtI8yOM3s0ADtPUdnAu5Zu4g3BLTJOqwTUQ3TbbwQywvDV6a/0qp42dyp81hoR7kAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502702; c=relaxed/simple;
	bh=wQi6f9TUoNJbKhoQQzCN8In8jokVJgFq3MvWZGU68VI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=P75NMGYZM6frB4NmzZUw3RAQaSZGF8L1GppyNDUxhinZA/cqpFHXjBuWLkxchByrYEZUlxraPRje08M6QsN+NxcbJFtyjOm58HpteNHbS8sAB5MgC+j8v0egPKDihsgBXF2e63W8KClXTMNVwBpzWBHbYQ+1XZ3Cwpvq/kQakvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=VEMOfIHc; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1759502690; x=1759761890;
	bh=wQi6f9TUoNJbKhoQQzCN8In8jokVJgFq3MvWZGU68VI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VEMOfIHcQqvIskGG3buhl66LVHWvCA6f++fVMRqGvz5wTrz6UJo8exRA1MsG0wtNc
	 XasmuMb6AlK/D1e+Ppe74qreuToPyhquJLCFnt4LHRCdTcUwMgxK5p0dKG5Pje5kNq
	 WxqYtfGiXtmkURqq8xI4apEULtFiRLmneeHr4/kQQj8zkRlKsL/9bVpkTl+MB6tpcQ
	 dpHz+xqNifhwCthlHQDExt8kf/PzS7AAo+2eLuWhTZ72hQJnQeIvgjCYuwpKTpRb9N
	 w+qV41P43hfwT2A9+nQBq/S39QDFHju170u7HId+9chL/nDvwpvYG988WKo0bEAsbl
	 C9oSaEYdHcyjw==
Date: Fri, 03 Oct 2025 14:44:44 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "??\"ceo@teo-en-ming-corp.com\"" <ceo@teo-en-ming-corp.com>
Subject: The Linux kernel just got some important upgrades - here's what's new in 6.17
Message-ID: <00AsMIzEaDFOGni5Uhauu0hGWU3L4LCVqOVhxhLwvqDZOqofpY9bqZ2nRzYrYxJtMslVU2PUFvb1sDEw-nAonuSNy3OQG9vjYO3be4adpDs=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 31a6ff3c895d7a7fababad79ffa367c586b3037f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: The Linux kernel just got some important upgrades - here's what's =
new in 6.17

Good day from Singapore,=20

Here=E2=80=99s a news article I=E2=80=99d like to share.

Article: The Linux kernel just got some important upgrades - here's what's =
new in 6.17
Link: https://www.zdnet.com/article/the-linux-kernel-just-got-some-importan=
t-upgrades-heres-whats-new-in-6-17/
Date of article: 30 Sep 2025

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Singapore
3 Oct 2025 Friday 10.44 PM






