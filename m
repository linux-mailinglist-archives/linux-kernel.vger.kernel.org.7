Return-Path: <linux-kernel+bounces-887002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF79AC3702A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45F784FE3CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59633E347;
	Wed,  5 Nov 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZQ1StzT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2032E745
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362430; cv=none; b=GGGCUNNP3XwpVkh/y+h6yLF1EcfycAuTGl991rARm2caDiO3GAyFOPntYQxO/lRy8EJbfhcc/cutUxJAGFVi43ms6h7Y+id+5ZmZ/7xkI+67KuDHff1DpYld9WFGgmCRbOl/LTjtN1MbPxS10w+aLN8axuCGQ5fCuqbrXn/btvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362430; c=relaxed/simple;
	bh=30t5zBtaGQTxkltEhveJdNA/C7vUJtmxHeQKBmULzL4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HDXxJXHBqMQPVmr6hZ9CCtWKxAMyTyhWKuT+6mdiIRVWBlW3ZD/GpTRMK8opSKnNHt9M+m1gMkoi93gyPC37ti+JOZZBHB3DU778qTKPTgKKN+1UWG0K+cOwlJQLaWT6Oy8XzELE0U8LQnAokTHbRA5aRRiwRKTek4e3Z4NOpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZQ1StzT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710653ac03so13015e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762362425; x=1762967225; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8KlH5oH4aa9xdiatpr7ssWlzRF67+KUJgkYqzSsS5JA=;
        b=aZQ1StzTzfUHcphbHnNYEC9Cs8ysFOMY0A1WezAV/DYvf67OG+LJX3s7PDZBd+RAKG
         IxJALnUx+fr4HZbGP3oNrN1CM/m+r82XKcycG0uzf8jFAHA3BhMyNvOcx/4Wmgq6NpcC
         X/PC4Z+G1b21S8jJ82RPm5vZTIzX9RdNpcuJv4ag7cKcKl3dkoI+9O4HeqlDeF9SQSBk
         XXqQZ5oazFt2E7ladl/v1NwjHdbHKM7ZR2WQ9ZgJOPy24I8bmj+9zFOiQZ3DVAVhCr5b
         p/ROw52D/ZuxiW3uBP3ySedD2XmTG3x9B5luNvPkePwCuCA5raPHnReuAfwIrUaf9tb3
         NLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362425; x=1762967225;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KlH5oH4aa9xdiatpr7ssWlzRF67+KUJgkYqzSsS5JA=;
        b=F6ek2yJN9R7GqQuA1oWlSOzorPzERtR+DvZ5LmeRYcFGKIDWp9e+agnRIE8gy5rH4H
         TVbErafRvcIaH0z5EI87Ym1uk/CprRlExwz0/bbIuUz+4V0d51Zs6rLhSYicvv3BmG1h
         SzdRvD1vr1LbLJoNtxMjD04BLhAME0R26RmjWkXyJkxh7KhFIg0LEyosUkOaZ5h9W0lT
         t659lOLIAHFjdLs192RU9jLPgLEgUm6Z4ffl0K1CEZxlbvpZSURdXGwA1iETVbnkmbkm
         OCngBzs2s58E6UD5CzpIAxyfDSOADylw8q00+8DbfEKvZjvFcWhK6N0Z7zwYmOlThgr0
         7ZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4WWP01sG78NdOVo76EbMkDwKZlTBPIPuGQhJZiYKCMgkH43lDa/XNbk5sEbPVVpWkKAsc4pUWt1UUFSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeAcpX5bFM/28/4fHXPQlj9MNHslPU6l9mupRFWNQkkNSiZYm
	WOmVcQGIfp+9RYlXCOR2ntN/Zym3ouWMyMGLoTtbpOrvhAylI2h7mKGW
X-Gm-Gg: ASbGncv2LOkBC3OwVQ0hDUmJOabSYQv979HaZwjikpmTEMq+YhnBuxxNU8gZ1IGdSIE
	QE3Kpmm82diGSG3pZfnVceIUdE0x1NwXIOyh2FqLdy03KOUAfY0CAjWg7U7iewacoWUl+V7dA2G
	DwRGRBx2nfVoEDuS+4+th4QT2cveJI2vwxbXbQa14Uz8mxxAFLZL8uwv0GmvBIPFsGLaY8RDCvs
	rKt/vfCRDE6QFby4Y85jcluG3eNU3cRhw4UOHYtqPe63tY0lyYkdD162E/dqW3v+blXgH6lK2ZV
	0kd0KphOEVT85QlNisKyXfBo3E/4mKEDyQ9VNOfF4qjwBiSCR/dyUBUggFQtCLU578wUMsf/mK1
	4bYddSONe2t9t75EcxZDj1gcvT4ge/prWyAGYunTIeOQG119jrPSayBs18meB5yDM7YMg+XoeCi
	423PyytdJZxCdYwEM=
X-Google-Smtp-Source: AGHT+IE2dFdyfyFz3wz1sJuNDVRHLZQy+AvcViqxwXwXlz2xC+2bmQlgIw1MzTy6Ou29bwSkDaIpLw==
X-Received: by 2002:a05:6000:420b:b0:429:c8f6:587c with SMTP id ffacd0b85a97d-429e3276ccemr1752428f8f.0.1762362425021;
        Wed, 05 Nov 2025 09:07:05 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:73::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efb3sm12774255f8f.3.2025.11.05.09.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:07:04 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next 0/4] netconsole: Allow userdata buffer to grow
 dynamically
Date: Wed, 05 Nov 2025 09:06:42 -0800
Message-Id: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKEC2kC/x3M0QrCMAxA0V8ZebbQFrapvyIyYhM1oKm0ZVTG/
 t3g4304d4PKRbjCedig8CpVslqEwwDpifpgJ2QN0ccxeD875Zay1vzihb6Kb0kL91aQsKGL4UY
 nmuM0TkewxafwXfp/fwGTpnuD677/AGaySZl4AAAA
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

The current netconsole implementation allocates a static buffer for
extradata (userdata + sysdata) with a fixed size of
MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS bytes for every target,
regardless of whether userspace actually uses this feature. This forces
us to keep MAX_EXTRADATA_ITEMS small (16), which is restrictive for
users who need to attach more metadata to their log messages.

This patch series enables dynamic allocation of the userdata buffer,
allowing it to grow on-demand based on actual usage. The series:

1. Refactors send_fragmented_body() to simplify handling of separated
   userdata and sysdata (patch 1/4)
2. Splits userdata and sysdata into separate buffers (patch 2/4)
3. Implements dynamic allocation for the userdata buffer (patch 3/4)
4. Increases MAX_USERDATA_ITEMS from 16 to 256 now that we can do so
   without memory waste (patch 4/4)

Benefits:
- No memory waste when userdata is not used
- Targets that use userdata only consume what they need
- Users can attach significantly more metadata without impacting systems
  that don't use this feature

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Gustavo Luiz Duarte (4):
      netconsole: Simplify send_fragmented_body()
      netconsole: Split userdata and sysdata
      netconsole: Dynamic allocation of userdata buffer
      netconsole: Increase MAX_USERDATA_ITEMS

 drivers/net/netconsole.c                           | 338 +++++++++------------
 .../selftests/drivers/net/netcons_overflow.sh      |   2 +-
 2 files changed, 152 insertions(+), 188 deletions(-)
---
base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
change-id: 20251007-netconsole_dynamic_extradata-21bd9d726568

Best regards,
-- 
Gustavo Duarte <gustavold@meta.com>


