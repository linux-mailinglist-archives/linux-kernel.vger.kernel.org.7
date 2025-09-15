Return-Path: <linux-kernel+bounces-816005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43833B56E13
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2581189A810
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5C3239591;
	Mon, 15 Sep 2025 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXHmoBRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB0122B8A9;
	Mon, 15 Sep 2025 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901497; cv=none; b=U9VmuBT3uPbKdJESgYbMK/32O7I/JUiphL7ep1BpoA52WKxJPVSBcWO5mBHqtvkJI2pNBJsBZDMsmbFx6+YifDmTmQfYxLG/xotw+QB3dgIQvzWW1AnqdF0hv++OyhTJ3om0nfMlDVo1tSBy+9JYXUN9SO5qyZfWM0qdmQnI2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901497; c=relaxed/simple;
	bh=3+9qSsAlg4qC3YbAA//ENyr9S8mCKrCXEpzivdstPoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxwoz8ZiNCH/l6IRNA8IKORNagjsMyFTNzzwjkKLgCa/LNfyI4jwMfaBQJHK3ND4PtsA1bSTHCaX3q5IwMz2JWr5Awa8mChBiZRD0u8Xy+gPPsT6o7i4a4KZU0/WRNWQQzidfMzaTVgQIgTNjhuJtvpxvaDyvn/Pz/Ws9oxcWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXHmoBRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602C0C4CEF5;
	Mon, 15 Sep 2025 01:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757901496;
	bh=3+9qSsAlg4qC3YbAA//ENyr9S8mCKrCXEpzivdstPoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXHmoBROJvMUvju390O3mU1he2Ful7Ud2Rx4qCKVAXCT2HixYfZFUBVk5mP8DWBK0
	 dPD6lB7bseP7avTwOdWTmAHf9tIPRRzV0NA725P9X3wnzFqQ/m2ykRBJDHYah1V71x
	 dWLQ2MWIqxE9Ybeu8yttGKAf5eYZKh3rPHT+70mI4EnN/1xag2HAjL2tsTYt+H/9YX
	 wk2psPIYwXKb8etxdZ2DJFGgF7+PH6woObe2ym2A4J2AT6axT+Qo+TXZdEi4bli60r
	 kv8bv5n0Mfk5kCF3gDPT7dtQqW45b9BoryfbsCvplZxtTZK7GbNRa6CIONumtJeKji
	 cHOCrjNcNxMIQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/6] Docs/mm/damon/maintainer-profile: update community meetup for reservation requirements
Date: Sun, 14 Sep 2025 18:58:05 -0700
Message-Id: <20250915015807.101505-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915015807.101505-1-sj@kernel.org>
References: <20250915015807.101505-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON community meetup was having two different kinds of meetups:
reservation required ones and unrequired ones.  Now the reservation
unrequested one is gone, but the documentation on the maintainer-profile
is not updated.  Update.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 5cd07905a193..58a3fb3c5762 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -89,18 +89,13 @@ the maintainer.
 Community meetup
 ----------------
 
-DAMON community is maintaining two bi-weekly meetup series for community
-members who prefer synchronous conversations over mails.
+DAMON community has a bi-weekly meetup series for members who prefer
+synchronous conversations over mails.  It is for discussions on specific topics
+between a group of members including the maintainer.  The maintainer shares the
+available time slots, and attendees should reserve one of those at least 24
+hours before the time slot, by reaching out to the maintainer.
 
-The first one is for any discussion between every community member.  No
-reservation is needed.
-
-The seconds one is for discussions on specific topics between restricted
-members including the maintainer.  The maintainer shares the available time
-slots, and attendees should reserve one of those at least 24 hours before the
-time slot, by reaching out to the maintainer.
-
-Schedules and available reservation time slots are available at the Google `doc
+Schedules and reservation status are available at the Google `doc
 <https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing>`_.
 There is also a public Google `calendar
 <https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`_
-- 
2.39.5

