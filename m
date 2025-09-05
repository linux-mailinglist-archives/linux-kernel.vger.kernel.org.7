Return-Path: <linux-kernel+bounces-803409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D65FB45F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC092A07E0B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C52330B533;
	Fri,  5 Sep 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaUa7Y2c"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CACD30B530;
	Fri,  5 Sep 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091520; cv=none; b=i+D4R2hFAcpajJyvQQe/dqvssFirSlYpVbSPAtLJfvkC0Hx9Yl24/wJJRK8L5xv/TpSv1nfJAzfEtokoOIdMdAT0/JVEVbgnWHtg+c3hASo2q9XRbbfJ0fet4180/YesdI4aW3vj8Bo2YYc4lXgg1xEcYJaSh79+z+UoVCeoOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091520; c=relaxed/simple;
	bh=GY5sV0uvjNxCwVURiY/QhPsK0JD0DBaDTBCBclskKx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hlc42kDiPlmWhnYCQk5rZPqBX6+3T1s6gZxArgJ1v6Qc4BQOxtoPzTqAjE6oPU7NLhqvGjScf9BJjFxU2NRInyHEB4ItY13xlHs7HHHaxqQLXtOIHqjK9XXjW2TqStS2BT7yHz8YhkZ/S7UihGzLuuAqbXCBYdqns8lGFTIETZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaUa7Y2c; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1895426a12.3;
        Fri, 05 Sep 2025 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757091518; x=1757696318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UTV25bJ0QHDx8oC1ADoQRhPgnqFtK+mmG6EkQFqHDco=;
        b=kaUa7Y2cvV/+Mn+cXNQAqncJUu9zPPea1pecCxSW+YEB6ANS2lF7tcoGJ5wudrl5eO
         hb35rZ1qTsNvKEgFoDxmXfZKQX2cOOOIR1CqDEbaiIVbLYfa0qA7D7YmHtSqV8NLvlyK
         2E2YGtRPMwrkvvDBF3CYXerX3yWjW47OKLkC9VgkKxuZ1eWlDjb+zMQ1UeZpwMj+aqk5
         LffeSqJOLD30hGZnWYXWMf6067C1YKx7f+M9PrLXFBSgtDzEinF9BeXF/ntf1l9NuinW
         pruhFVm5NVVYrtW5cKC/7Qgtty4BqvruXC+jifXDXhj5YRqFIxA5XfNSW8rV5gyPoGaV
         K3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091518; x=1757696318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTV25bJ0QHDx8oC1ADoQRhPgnqFtK+mmG6EkQFqHDco=;
        b=wDBGRb/mJ+KhHVStc/m2GND6DeWa87LO9kvX6KmNvlK9iADrM5veQkbwyVkfN0mBA5
         ZvuUQtg4aXoWDhqtlgk144XfWtOmdpHqGAC0dArh8tD6vlmCihPIFLtBjuW0R6NcZ/xq
         NdrIQkOC81zcQUDma9EWzVQH7skLrLWxVAdiJHWEPedbteJCyW2sDjcP4ToaZ1RtpWU9
         +WKOwRAyJaiU7DBtBwDMl6lQOOofavPT1NZa904FtabgfbG15vz/F22u3hX6pzPt+b5x
         S4S11cO1hoRY+jlFCuztZNC0K/luIjye78/UhZcCt4yRg6ijcoql/xmoWeJaSS4iintN
         6USQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfvgyrKPQsmYo6TEdUAvIkdvbe3v1PdXKIgFVQ9TKkVTHzBMONY7NNjCN4L0I2lFqrJccQXQdRMkzyg4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YysreUd5LaIh5JvXzrLaNLISfI7KFIbkPFGqDg0u5XcWRfv/Gxo
	uuZQW8W+NQf1/359WSfqk8FzX1BgVXSZ2eTLhiTsyyorCPsaP/iyrGm7HndBQBkY
X-Gm-Gg: ASbGncto6ehL67psqxowd7JCn0cEWivHHd8XfCIvsY62/rm/wZIq4/B0+YJ9Pq+U337
	DFJJbg9gtOJkEZakJ3ojSdbMM+OaaIcl4i7gD6/e1lZIUHoXUVWleOw1VFYrtd3Oyd8eqf4fwxq
	WDTkjyK0QXkZcnjRGlFPJ5ECTcNXefbX0PpeTVf7rZeUIeghDDjvEaRkXxRvK+zwmGaR8i4mi97
	++dABh2vUZf3gYQ1CYa1C5i12ih1ftBXPZd9SpE0hSapkCr8GW44zqkc6S7dUGNPIHNqnTP5Ybg
	nNP56QCS1HImaDkYR9nBf1xPA9ql7oWWhEpnEU9NW1r3sODr61DzcPr9kYaU5JpvJkg19oOcwYw
	X+IQ1VTP8zFe82fsd9a0ZtvuCSZ3hzYOjHGjzrLdtYpmlaw==
X-Google-Smtp-Source: AGHT+IGPP7S+GDY+NHU/RVuoBKdrlkv46QNH1BjxC4oqKJ6toH50fXv7b/F7fCTzF8ljKeVbbF/hdw==
X-Received: by 2002:a17:90b:380a:b0:32d:3e1a:79e1 with SMTP id 98e67ed59e1d1-32d3e1a7f6bmr199327a91.8.1757091517732;
        Fri, 05 Sep 2025 09:58:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32bd89c530csm827628a91.4.2025.09.05.09.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:58:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.17-rc5
Date: Fri,  5 Sep 2025 09:58:35 -0700
Message-ID: <20250905165835.1653373-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.17-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.17-rc5

Thanks,
Guenter
------

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.17-rc5

for you to fetch changes up to c2623573178bab32990695fb729e9b69710ed66d:

  hwmon: (ina238) Correctly clamp power limits (2025-09-01 08:03:05 -0700)

----------------------------------------------------------------
hwmon fixes for v6.17-rc5

- ina238: Various value range fixes when writing limit attributes

- mlxreg-fan: Prevent fans from getting stuck at 0 RPM

----------------------------------------------------------------
Chris Packham (1):
      hwmon: (ina238) Correctly clamp temperature

Guenter Roeck (2):
      hwmon: (ina238) Correctly clamp shunt voltage limit
      hwmon: (ina238) Correctly clamp power limits

Vadim Pasternak (1):
      hwmon: mlxreg-fan: Prevent fans from getting stuck at 0 RPM

 drivers/hwmon/ina238.c     | 9 +++++----
 drivers/hwmon/mlxreg-fan.c | 5 ++---
 2 files changed, 7 insertions(+), 7 deletions(-)

