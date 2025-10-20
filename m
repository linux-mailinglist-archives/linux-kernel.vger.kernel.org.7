Return-Path: <linux-kernel+bounces-861815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D0ABF3B72
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D25584FDA20
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8FD3346A6;
	Mon, 20 Oct 2025 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox8MuBC0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65BD74C14
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995423; cv=none; b=daItfpXHzTQqqduBaaMliImggPn0Me3LByBQk4i/ueTUfWDoYTcghFLQg/wVxrbF/5xBvQtI9f2QKP5y8/ZwHhB3X+rBfxVO2a+b9NARc7Wk5BnAjUKfreydjpbPJsM2aUVH+0tjpagWsE3vplfkFrXeRGFD3nbYIuvZjIdkgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995423; c=relaxed/simple;
	bh=y5iA1ikAfECkZaM2ppLR4s9T7RFPAKZ2pa2tj+ftPvI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ifi4OrNxWV8CUABSJWkglamNyuzLkUAj/T0hSSSvhsGoLumN73kXH1ZH5yVDn9JhS6ZRe28632M0MOCioh8uit43k9nwKKGnT514afh1tX5/GYtrEJNE3d9sOMRimbcNtbBwpZE8xM/9KOxk1tFY7x7ZClbH9Ho9biOQajHbD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox8MuBC0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-472cbd003feso739505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760995419; x=1761600219; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlAkTWKCIa+XIp6VLDBKo4NPyS8c7l95XK4IrTHifyg=;
        b=Ox8MuBC0KOwcaEsNmQBD+4nEgv4AhJpoM4nmlrtl6neK04/PLZ65CIT5StgD0hpmnG
         Y4UP73CDQPMrXiWx609ODUQt3tg38M0HEA6RWmf5lGXz0iFRfe6Lw3vX2pFh6QFFFdxF
         H91G3u2Rjt40qut+r64vIpsRyYHOVN2TrVkpz8UqgfyFBJXulVshS56wVlpr3BCH/MOh
         5rkQX8s9U85r99bHefZw2jvepzxD4ijWnZ3I6MmBfdOAvQbUb6SHgJPZxP72G6PIc1hH
         mB7mHs9QJ5hzuj/C6iUwffjm7TKCLX5B/gArFQIo92F90nUGh3HfzYw6D2sF9gRt3AZe
         ofow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995419; x=1761600219;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlAkTWKCIa+XIp6VLDBKo4NPyS8c7l95XK4IrTHifyg=;
        b=L2RK1kaKEDNw8IygofGpdoD4aKUaeoazgqavGt8kGtcMufWbgpPj6k++emHRP9dWsi
         F7kMooojMjG0cdfSQl081KpKfbLYj2mcPdlAjGZcdnXE/rzmXbiIWT37ZZ43R8UOClAn
         B5cpkzXwpbK90mT2VW9xa+wuXWx1UccxfacQcMva2MCCEj8ab6/3WbTTTjbu+8VQTTtZ
         3m1LOcqnLH55CXoloTImC3ZtNWFtGfedsoHkVYjHVjuyKorqv2ovuxRwcPky7L2Ijes3
         +Bl37dyymxADjy8Lu2hNWGtBcKYb9FidThxkk2JW0BSVtFM78lGvhC/yi9fNdycvLIGU
         bXFA==
X-Gm-Message-State: AOJu0YzTA+I7Wm795LDOFVNDKpw5EHZO+DrjNbB0IpXPHR/O52VtbFWZ
	1c6o+yKFTW4/p2WNnvaEiq3wrO6RxXeEPRqGWh/jj2u3q7AubAVfCuwn
X-Gm-Gg: ASbGncuQ4XkWEs0vBht7OGXj4sQRd+PJrjXa4uMuquHpfppU1g+LVWUjBMIGV/4o1BC
	Ga/zmdHhTfD84VRw3ZRiFpIOcc0L5uZOYwEOp6Ota5eOUa2cgJfD5JuUHh3t6LM3dtCE64Z28yM
	XzzTGpcHR0h/HhwPySH+isFfcnndpY5dJ/O/jjVrvKTLd21TJZ02mKStSGlVMWjery418oqYTLL
	CyQ/i0e0ufr1Y9C924C9lTjM7clwnwwWrrxWMRyowlW84PK3BxnZFvHjiH0/y98QnAFQ2lz4ImX
	9ZFZdrsL6RpJ0s77uqim/i5LleG5rKwwA2UX2um0ijzjubjCmouN5LYUPjx27xPJjZjN7+b3NO4
	lpmV6W9kI2ewPJsC2A71GsX+TUfpNQ0gUrOD6eTsiM0MdWHcXBDnHEVvWI9GVNots3qOOCmXqOr
	Lbc3Algt4XHggjjCw=
X-Google-Smtp-Source: AGHT+IG4VUh+DekCe6fz1qa1aR1wOBnEoKj+UFnhE8TaOTa2kaGZxEVHuJSeXnaK5aUGhEBMYpvZiQ==
X-Received: by 2002:a05:600c:154f:b0:46e:46de:ebdb with SMTP id 5b1f17b1804b1-474943c0ffbmr4677865e9.7.1760995419100;
        Mon, 20 Oct 2025 14:23:39 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9fdfsm16901776f8f.40.2025.10.20.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:23:37 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net 0/2] netconsole: Fix userdata race condition
Date: Mon, 20 Oct 2025 14:22:33 -0700
Message-Id: <20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABmo9mgC/x2MUQqAIBAFrxL7nWCWBV0l+jBbayE03IhAuntLf
 294zBRgzIQMY1Ug401MKQo0dQV+d3FDRaswGG1so41WES+fIqcDVaBHZedldL0N7bDYAR2IeWa
 U769OIALM7/sB3/8sumoAAAA=
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Matthew Wood <thepacketgeek@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

This series fixes a race condition in netconsole's userdata handling
where concurrent message transmission could read partially updated
userdata fields, resulting in corrupted netconsole output.

The first patch adds a selftest that reproduces the race condition by
continuously sending messages while rapidly changing userdata values,
detecting any torn reads in the output.

The second patch fixes the issue by ensuring update_userdata() holds
the target_list_lock while updating both extradata_complete and
userdata_length, preventing readers from seeing inconsistent state.

This targets net tree as it fixes a bug introduced in commit df03f830d099
("net: netconsole: cache userdata formatted string in netconsole_target").

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Gustavo Luiz Duarte (2):
      selftests: netconsole: Add race condition test for userdata corruption
      netconsole: Fix race condition in between reader and writer of userdata

 drivers/net/netconsole.c                           |  5 ++
 .../selftests/drivers/net/netcons_race_userdata.sh | 87 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)
---
base-commit: ffff5c8fc2af2218a3332b3d5b97654599d50cde
change-id: 20251020-netconsole-fix-race-f465f37b57ea

Best regards,
-- 
Gustavo Luiz Duarte <gustavold@gmail.com>


