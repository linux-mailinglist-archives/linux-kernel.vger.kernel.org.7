Return-Path: <linux-kernel+bounces-755192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED8EB1A2D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA8D3B2DCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB06625B2FF;
	Mon,  4 Aug 2025 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="m3bm6weN"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169B1DF256
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312858; cv=none; b=HLBtY5To6vPe8qOPUwC1R9YAa+2MrPdY+11JMBXfrxWpk68irwkWjKxfDw6LWPVkvdCxjTE5rjBWG17d1YbJtu0PBpVUD6VbX9CrtzWSmTGsayxyFFWcTk2Wz86+VWcHuD9eRSXsQYPq7g0/I7VYXUkSgPx3qJeC8FBebs48El8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312858; c=relaxed/simple;
	bh=EJNQCyNz0PLKNTrOoLJGQj+Vhu9yhTehAP5cHHDeIgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PtvHPIQS0qdqvStMVs82neXlzVD6PclatkJodLKlO0VFxQODK/5pN+vVKCxecuk95DB5ya4TvuJEBY1KxYk3aVdITbjM2q/2kOmbVuNGV6VH1kmad0cA6QuXXW7DIYQJRWcPQJoXJtUGA/RZxGgU58UJB0vGEgpfXogNTZ9YKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=m3bm6weN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:References;
	bh=aNJT+D3EnqA8HPbZf4nC0tytmLV5BFntMMq3ybl6Wzw=; b=m3bm6weNnYggyafT6Qw+msQL+p
	Txe8mmI68Kqn1K4aHoGhdAnibH4B5KFUig30SXQk9ovlYHYOEXCOqI+GZmj4AaErJy+0qyhjq94VF
	RHisghZ2DZEkHgahgKfbn+H4wAwhNnI57uubo8/LdoTudJ4wjF2RUUNTVCiKEUgKpm1cl0wmm1d+h
	s5mv5BQz3DabywUMClJbRj2tiscNquOzEIwhaeQoBetmMBZ+QRABJ7hvEGbCuHWHpBrIefkQs2dNU
	o1QdzFrr8spZH4jnqOFLllwzUEEzEgAWCjmsMhWd8P1sggmPDY/d/tcEAxQhbKQpuJ/Z2X3wVTMC4
	/6QHUboA==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uiuuc-0004Ov-HB; Mon, 04 Aug 2025 15:07:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mfd: qnap-mcu: Some fixes / improvements
Date: Mon,  4 Aug 2025 15:07:22 +0200
Message-ID: <20250804130726.3180806-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While digging through the mcu functions, I came across some deficits I
introduced with the initial driver submission, so trying to make that
a bit nicer with this series.


I struggled a bit with the ordering of qnap_mcu_write error-check
and conversion to guard(mutex). Converting to guard before the
error check would need dropping the ret variable, just to re-add it
one patch later - to not cause unused variable warning.

Additionally the error handling could be considered a fix, so makes
sense to have in front.


Heiko Stuebner (4):
  mfd: qnap-mcu: include linux/types.h in qnap-mcu.h shared header
  mfd: qnap-mcu: handle errors returned from qnap_mcu_write
  mfd: qnap-mcu: convert to guard(mutex) in qnap_mcu_exec
  mfd: qnap-mcu: improve structure in qnap_mcu_exec

 drivers/mfd/qnap-mcu.c       | 30 +++++++++++++++---------------
 include/linux/mfd/qnap-mcu.h |  2 ++
 2 files changed, 17 insertions(+), 15 deletions(-)

-- 
2.47.2


