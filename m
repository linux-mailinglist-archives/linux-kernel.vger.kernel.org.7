Return-Path: <linux-kernel+bounces-776358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F7B2CC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B835D3AAD87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901F3322C69;
	Tue, 19 Aug 2025 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="PMm76u6X"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE112BE7A6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629215; cv=none; b=hs5xGjObfB5h6K/y9PjnFKiCp9SNC6+iQteb4Q2k1B9U5IoBgtdaAPgLqHX3VyPF+lYfrnjqTl/kesnes0IUlEofZawuB/m5odafOuIQyIAD5rk3TlC/U4CQ9KLN1P0iDDT4P7zXaGvMfNfkk9mcGiY0FzYyGhuBKoDTAn063Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629215; c=relaxed/simple;
	bh=C1oojjIdYBWN2rqYk9GOAu2cy1ONfZnbuX31SilNkMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xbf2/f/nWrg3VhPJ3s+TuqEgzj0uqFoDxC2JONf3r6EjEzUvNuaraPkdlhR58ww+TrokW4iSk5iIVtgydVhtw+723RDs/Bar6BCG3RA0qxZnFOUcHmN99wl+uA0VyBlMYIw92Ld9NV0a8gIRVaraVh6QLB5U5JvEPyOAsGE1aEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=PMm76u6X; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 4163640A3270;
	Tue, 19 Aug 2025 18:46:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4163640A3270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1755629206;
	bh=TKOX4WsFYlLOSjVO8yf5i2uZuA03p0XzpB8Q5DtAk/w=;
	h=From:To:Cc:Subject:Date:From;
	b=PMm76u6XZuiqhrWCFEpsY0v7SQnjDBl75MvvPYjmJvO7oOBoYqeA7Xcwkxn3fzG1M
	 M46aD0OyFmf1NkXLXjgtVwWqCNx8xvuLxp5w3uDvp/Gq+6bONOfG1cvzWAjffszdC5
	 0ITb7tmonhWjSIlMfQqZ9sguRmptv77TmDR9qmRQ=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alex Deucher <alexander.deucher@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Harry Wentland <harry.wentland@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Hans de Goede <hansg@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2 0/2] a fix for connector modes leak in amdgpu driver
Date: Tue, 19 Aug 2025 21:46:33 +0300
Message-ID: <20250819184636.232641-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is a prerequisite exporting a convenient helper at
include/drm/modes.h used in the second one fixing a leak in amdgpu
driver.

v1: https://lore.kernel.org/all/20250817094346.15740-1-pchelkin@ispras.ru/

Fedor Pchelkin (2):
  drm/modes: export drm_mode_remove() helper
  drm/amd/display: fix leak of probed modes

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +++
 drivers/gpu/drm/drm_connector.c                   |  8 +-------
 drivers/gpu/drm/drm_modes.c                       | 15 +++++++++++++++
 include/drm/drm_modes.h                           |  1 +
 4 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.50.1


