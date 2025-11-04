Return-Path: <linux-kernel+bounces-885062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C04C31E39
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5843A366A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309C328B55;
	Tue,  4 Nov 2025 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="rGvpb3Je"
Received: from smtp89.iad3a.emailsrvr.com (smtp89.iad3a.emailsrvr.com [173.203.187.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C531B114
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270610; cv=none; b=FAm371sb/rk2kRcaOSwARZB2BvbZr6aJYA/ZhH3CImh2I5pjSOySKb3azmXlHqyEOTsMEG60I04m7okNJUjZEfbVlrAZg6xzGzn8VJCI9CAvnvI50TAOPlsfOclBnY64B1xIOm2Wc7jofeXoZ7A7AZikmOsc2a76wmJk3xz6HC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270610; c=relaxed/simple;
	bh=mUUR1G1DTJZl4OVssdJYBF0fMrKO32voReACZE+Z8G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1jWUa1cEaxho7B7umTrwoPXRGU44Got6jYV9wMQ6yMfuh5B3vGM/5BsuP8YQDFYc1R44C3hYrnMWns2SBpozQ6bS/jDaylLyBAcdtMGJX9zch5Br+quqOp9NSKQ+NgO3uOMyVwvITDcKpK6YsGFZvAdAcevPvPEiWo3+rPs0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=rGvpb3Je; arc=none smtp.client-ip=173.203.187.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762270228;
	bh=mUUR1G1DTJZl4OVssdJYBF0fMrKO32voReACZE+Z8G0=;
	h=From:To:Subject:Date:From;
	b=rGvpb3JeW8vB2taoLFAus0dINEJ/lcB9rNE5cg+8KZ4cSxPqVW52vpA42sbGvn9KP
	 9r9830hlU9imd2oZsSXmM+o1frbu5Xv0WgzOc1MuH2pe5Nko2wwO0DfbZMkLY8Lrd1
	 n4SW7eSaRsoRRD66CSSVmOikimvx8JhSFOnxLz2I=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp4.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 8B8843CE1;
	Tue,  4 Nov 2025 10:30:27 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] fpga: Add dummy definitions of API functions
Date: Tue,  4 Nov 2025 15:27:01 +0000
Message-ID: <20251104153013.154463-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 7af648e7-5513-437d-9d71-25d484e80853-1-1

Add dummy definitions of the FPGA API functions for build testing

1) fpga: altera-pr-ip: Add dummy definitions of API functions
2) fpga: bridge: Add dummy definitions of API functions
3) fpga: manager: Add dummy definitions of API functions
4) fpga: region: Add dummy definitions of API functions

 include/linux/fpga/altera-pr-ip-core.h |  8 ++-
 include/linux/fpga/fpga-bridge.h       | 75 ++++++++++++++++++++++++++-
 include/linux/fpga/fpga-mgr.h          | 95 +++++++++++++++++++++++++++++++---
 include/linux/fpga/fpga-region.h       | 44 ++++++++++++++--
 4 files changed, 207 insertions(+), 15 deletions(-)

