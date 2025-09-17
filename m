Return-Path: <linux-kernel+bounces-821416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F975B81340
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A1E465F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F162FF64F;
	Wed, 17 Sep 2025 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="NAezXF+h"
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8CF2FE57C;
	Wed, 17 Sep 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130669; cv=none; b=QHtWNDt97DAqbuily/pe4Ghz+Y2NVVv2jJsuWWgbjXoJbLKUnXkX7+iFw4PGLiQlGo2L1GK0ELvGVvxy2QxRoUouKXUEvRSZ+QQL5Z6OK1Q+jjkLWtmjx6/IgJyj2dLmOv/R+uxvQ2TBl5fx0/ol+1Kzwf7WOsKYnuLcLuIGeQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130669; c=relaxed/simple;
	bh=dkqb8s/BOFFYgBdG5QRqv1643pBP6w+U36kFuzpo/AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fldv/784AssvLk0f6lRLOAg5J9dMegXzrutObBKZxGjQed1IoYpKXLxlqWpV6FXLhNY2RiBw1n8L6zy1XHiWBNlnu4aZVjgCWdL/16wldORolt4fefnd4q3uzi6uNYtaCYn7IuewqujzQHuHj7lYfRhy6t3oF8AVcGcQ6yva3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=NAezXF+h; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3d8d:0:640:b127:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id C3D65C003C;
	Wed, 17 Sep 2025 20:37:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QbVY4BEMvqM0-hhqJFHSL;
	Wed, 17 Sep 2025 20:37:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1758130658;
	bh=PIbd5726Zt39TgRCAWlru596MC6caJ75PRkgzEXl/4k=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=NAezXF+hgus4pnqogHyH5/0bEXmjpvCLdiH3SkeO12nbbwbV2fw3Sb/5P9IgBjS7t
	 NLOSmU0WhWGFkgxUwv+gnXpK9ox7FL01N06kNxLPd3eHGRSdaYGAWH0eNsE30kuclb
	 DQ5+fuhQEE8XQg1bNhQU8Xz57SsZjL4R/Kdw6AjM=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2 0/2] checkpatch: add new check PLACEHOLDER_USE
Date: Wed, 17 Sep 2025 20:37:23 +0300
Message-ID: <20250917173725.22547-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v2:
  - The check is documented in Documentation/dev-tools/checkpatch.rst file.
  - Used ERROR instead of WARN on detection.

Onur Özkan (2):
  checkpatch: detect unhandled placeholders in cover letters
  checkpatch: document new check PLACEHOLDER_USE

 Documentation/dev-tools/checkpatch.rst | 10 ++++++++++
 scripts/checkpatch.pl                  |  7 +++++++
 2 files changed, 17 insertions(+)

-- 
2.51.0


