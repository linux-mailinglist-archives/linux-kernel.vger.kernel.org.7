Return-Path: <linux-kernel+bounces-878858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD66C21A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3069A4F11D2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804F36E378;
	Thu, 30 Oct 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJGrP9PG"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4B5374ABE
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847098; cv=none; b=nLkCS2TkVEGp5Ue2ZV2f7xBvyaIwLTe+rs6aBQBeHY74W7fCKu9+Xs54gqJOWWm4ESGwnkhU+2zUvXHYHykYIkVe9nfWiXTQ/j2UwW09hFlA51VP97XwWkqQbZJXWaDL8+WCK8013YGzZbOlDd94UADYnLxS0yOeiIxzTt9glN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847098; c=relaxed/simple;
	bh=E38nvu7KZl9ndawJz1k+ZLfO2UIk6shCOOTboPNO/UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5Zk6qlwldImwI9+XHmx9Hi43+79QYbJCT8RbFhvDmTq7rWjzOn4xnQxt9VVJAMZoJKn9yo4PFjEf6J96S+JLypaPg9CyhVuQGcLE/5+UOKJWESmyFLOBhy5U5jOVv5WiYYMEAp56v4Ea6yjPMRBdJrv/q0IpEIYZVKwXe0qiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJGrP9PG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47118259fd8so10514645e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847094; x=1762451894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gzjCSWSDa5dSUjUZXovzi8Fx64Uy71ap0+jFlPPV2w=;
        b=mJGrP9PGkzlNtIXEiWsi+sxSdDg1ESINGqHdxXWAJ9jBz5H7QH+DCVNHuy42+dUrCv
         jTNAWxeGlHyDEbZPMcD+InDUAqzhYW5ZQS+cwnHOEDGE/+Y0QX0Ems/605ONS7nG0ssU
         EFg9u7hXhzN0IF3TlOeI6ZNJkbm7x82gLnwsTiM4/cNRD1ury9AZksWTrwJoRXYwsnTi
         wtu1X8CvQouyv3SJq/8kEP24PVbWb7CZ+3GHFojXYgC7rTxkdvEpfgZsTZePyGTFhpa0
         3fiSE3DanTE+GkCYGCSilW79kBdTwldKmDHNlU2fKMDEe6LdZjetQRWe86tfamR8hz7s
         oDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847094; x=1762451894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gzjCSWSDa5dSUjUZXovzi8Fx64Uy71ap0+jFlPPV2w=;
        b=omVE5jYe7tfwxUEzsT9dvwHQqgWWD+BSBlqXre/wu94rGGRPY7FTavYCTH+zrlC4ke
         DKfTN3jKwKFQ1AFtOaNllJbdn2jxsnvyAuWyGswsfI/o67KGo9sydrMXmL0UAYZxXiga
         tdMk2Ss6mUcKOVXYJDGoGe1ePvXqkdnW0/1slMDy0S8dXyYuKhv4xs1HvnUJvcaqEM2n
         AtisPHMdy7h5oWm4Hy777YzyeDqE5fh8Zkkpog6+kZn7VyXxgEHUruOqPxmWdXV0R1Bk
         Xm3nYYpQYTwtwOVhM9fKghOgRW3KmUF7yger6Uc4m9TbtkVz8OYTexTOU1y4zFbO5EVr
         N6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUv0mOd90CEIrhuU/grf5Ikl6cPVpFbaz+YU7/z4GLHoUibImdWDU+0URzXKT7R/tvyyr5zKGp8v2hJSfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzowp61xrChxHYbzgKJe2iviRW/1mJ7u9AOEfl5npvNitGqjsWB
	+ZQs/g9LxCwQAly2F6YUY7yU9DnTSJHik9pLXbdiW01k05rJK7NBxy6p
X-Gm-Gg: ASbGncum/zA/reFFP/Ipo480R7A6jItITNwsxowfyflIjM4kWQg7InD6wOxpY//JuqK
	rmOmKNFF0PC7V76XqKxW/CrZ9Rk8sSs7P2N1OeUtJ4mdS05ehgdRV82PrwNEZY49tupkKLlidtW
	UqW9Xsrek460X1X3uE7yObj72SrRby3WFEMBxmXS+mwPLnW9hitXK8P4jaKksY9wx4dJN1otUmH
	oy0NwLLk4HMA1nGde5iT33sgunWcdfgGdzNH12LFpW1wlEblvm0r31gc/5sxrMf778sVo9yMcVV
	KQRrbJ6hVU6WTorYt8Mp/wFG4bIczf/bbyCxsAvGUFtsgOrG4QHTGkzdp6Nwqpl7Vf5wH8xaB4h
	8pA3BwS1mZ/idpS3WH+zFqJVbmQ7ugcnNRZhYNBScrx+RpeP6VaGgcu/EQCXH409ZjQoD+Keebw
	vdpRTBUmqNhG07A0alVIOWabihCbV6kHdEERLayUDREWjKikZBSyV8wEgY0nu4ujxTTPYj43c=
X-Google-Smtp-Source: AGHT+IHdSgxpcXTfEej5U8BldtuGHfSvdPoMRqZKYxWXFAr619pzocHitxlzzBZZ5iYo55mAH9lB0Q==
X-Received: by 2002:a05:600c:3b2a:b0:475:dac3:69a2 with SMTP id 5b1f17b1804b1-477308b0611mr5390475e9.27.1761847093974;
        Thu, 30 Oct 2025 10:58:13 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:13 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 00/13] Add RZ/G3E RSCI support
Date: Thu, 30 Oct 2025 17:57:48 +0000
Message-ID: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on
RZ/G3E SoC is similar to one on RZ/T2H, but has 32-stage fifo. RZ/G3E has
6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
(2 module clocks + 1 external clock) on RZ/T2H, and it has multiple
resets. Add support for the hardware flow control.

This patch series depend upon [1]
[1] https://lore.kernel.org/all/20251029082101.92156-1-biju.das.jz@bp.renesas.com/

v1->v2:
 * Updated commit message for patch#1,#3,#9
 * Added resets:false for non RZ/G3E SoCs in bindings.
 * Increased line limit for error messages to 100-column limit for patch#3
 * Updated multiline comment to fit into single line.
 * Updated set_termios() for getting baud_rate()

Biju Das (13):
  dt-bindings: serial: renesas,rsci: Document RZ/G3E support
  serial: rsci: Drop rsci_clear_CFC()
  serial: sh-sci: Drop extra lines
  serial: rsci: Drop unused macro DCR
  serial: rsci: Drop unused TDR register
  serial: sh-sci: Use devm_reset_control_array_get_exclusive()
  serial: sh-sci: Add RSCI_PORT_{SCI,SCIF} port IDs
  serial: sh-sci: Add sci_is_rsci_type()
  serial: sh-sci: Add support for RZ/G3E RSCI clks
  serial: sh-sci: Make sci_scbrr_calc() public
  serial: sh-sci: Add finish_console_write() callback
  serial: sh-sci: Add support for RZ/G3E RSCI SCIF
  serial: sh-sci: Add support for RZ/G3E RSCI SCI

 .../bindings/serial/renesas,rsci.yaml         |  85 +++-
 drivers/tty/serial/rsci.c                     | 412 +++++++++++++++---
 drivers/tty/serial/rsci.h                     |   2 +
 drivers/tty/serial/sh-sci-common.h            |   9 +
 drivers/tty/serial/sh-sci.c                   |  67 ++-
 5 files changed, 492 insertions(+), 83 deletions(-)

-- 
2.43.0


