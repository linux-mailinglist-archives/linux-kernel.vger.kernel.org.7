Return-Path: <linux-kernel+bounces-896579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 247F4C50B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC8B3B58AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F042D73BB;
	Wed, 12 Nov 2025 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UChEiKpH"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0F9476
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929051; cv=none; b=R2Hwx1c9JL8C2lUJ3HJkP1MQxLrrQ+tWcPbn3ZnN6jSdeHS5FHVtDYrPxvUhhdKabNB8z9NI/3bNjmbAa49M1+HLvapPB7Jme0B9QZqyLLj+r0S9jRy4aP95ZFrt8WWz6Gpr0/8oiv0tvc2RC5kfeatpXtgGQ7JpNUljrKVu5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929051; c=relaxed/simple;
	bh=kOtdLpSOXm01g2ajg6nCUQyFUDPOfE5SRjD63G5rjgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s6nCe6uEEuEeU/3bJFRQKhNvjGYtkiP6TvioQEdI6wWTvMv7YgodHuMh963Yz4j0GmGoYT+xhRoNfxT+WXJN+IGbHATumz5vcoTGBFOWJMnuIB+0trETXwbKspMNY3dMtztP9RSkP/FbKaclwPyCF5hsvqJ7foWA/bkloJ+ip7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UChEiKpH; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88246676008so6460796d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762929049; x=1763533849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BjJJZtAaSnwRZTljAMTrxcYfYnvT0WqvSKI0ci9ciw0=;
        b=UChEiKpHpZy1iRCXjP3TyjzX7t/uDznqRfZE/pXgMOMRFcUEnG3fFm9PaodMdwXJSw
         E2unYzYw0QPOmhN2LnqFoh9DDkiYYYPXDRKR7dlWG+5PismJPBqWLnvFjqxy0AHq77pg
         DBLWpfwtS5HR7e5RiOMki2ZvY2+02XgUIzA6ZJZVu0MsYDyqAWp4Q6lUoDj0p7+C/kGt
         amrZXKXTuLPtlakM3i6oblhUU7Z43LMrQsC5JtanZyj6mUyOJG37/pbsBMOtp61Ii71O
         JXB67oB3cWpoST+fn8LCsDceZIpMDhpCerD63+Jhdjz51cqf8laWiXzL21qlfN5HrgUU
         W/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762929049; x=1763533849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjJJZtAaSnwRZTljAMTrxcYfYnvT0WqvSKI0ci9ciw0=;
        b=VdBCtOrexn0SplUkFh0pF6941PQ2T8YFmnV3xFAUv+yz4esNcuHzvjJPNyrBxKI8AF
         d5f/1OuQCXZgOJgsm/irhrVa/OMpPx+v71G7viAOuCIJRPTQVAUyvLNzWw64Tgq/EIzz
         OO+j5BcEAnfXjzp5bfab8wowiwwo0Mq5TMqDMw2J1ZfYYpQmcRsNrnLJuLJuF61LETH7
         vgpKMn6npTn8Le0tApaukSqUZuuoxXcEMZK1R24Sw0OoRomGtUqhva/+JkAIExFftlfS
         wCOUUmZgVAWgWROZ/sKa50YLKFMD8KT8UlcWOdNh02W3fnR0RPK4sA4OCHkj0vVv0a6A
         N8Sg==
X-Gm-Message-State: AOJu0YxxTzRbBVU0lkQ6yCB17drcZfl2Bq6PMJOcW/jyRQr53NAw0CqM
	9zbhaFezUAlQNGQNUV+1r3DUK7ob5SEczyfOujyFmXce0sCBsWl0qunU+lyh6Q==
X-Gm-Gg: ASbGncuD7eLqwiUsIKeoWmfddL0LQlu1SyBLS73XczFP8brcNk3JBFycBdUI/itgkzh
	xEOYhb5WszBJEQyj18krM+OBoQb36FgDUN+kzNZfLth/bSx2Xw1lCNzfqccFVY7n1vpIti4c2Cx
	5EKXHOxOFMBtXe/9r98PiSnxYWK0H57uaXs9QoOW829CJKmQcZGo/eG5pmo/iL6WKsHnuIo/+H8
	e1A8rjrk1O8pmS5P7YrjCsDFxnz1O0OUyO02lz22NXewQ4LIb1wlzJZxUOhX6x9aYQcshiVdR1K
	eAL5/FYnxyXWuEtlJ9gcCdIC2bVFnCzS1tSAPWd8x3uYZ1q8gkZJZo/ItDxWgYI0yKLhNZdhF/U
	T/XrYUustoaooJwLvmUS25RE3dVkUXZMZwKuDkeaXcXMOYNw=
X-Google-Smtp-Source: AGHT+IGqNhYmOdKeltGLX/KLSKoplWtPXoQM3NK5fxBoy1HIki6VZdr524CffwyRwqBnNuhXt0GvEw==
X-Received: by 2002:ad4:5bae:0:b0:880:4219:62c1 with SMTP id 6a1803df08f44-882718f7cc7mr29723196d6.15.1762929048854;
        Tue, 11 Nov 2025 22:30:48 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882638344cesm24932036d6.42.2025.11.11.22.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:30:48 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCHv2 0/2] firmware: stratix10-rsu: add COMPILE_TEST support
Date: Tue, 11 Nov 2025 22:30:31 -0800
Message-ID: <20251112063033.176276-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

First commit fixes 32-bit target compilation.

Second adds COMPILE_TEST and cleans up the depends.

v2: remove unrelated changes.

Rosen Penev (2):
  firmware: stratix10-rsu: fix 32-bit compilation
  firmware: stratix10-rsu: add COMPILE_TEST support

 drivers/firmware/Kconfig         |  2 +-
 drivers/firmware/stratix10-rsu.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

--
2.51.2


