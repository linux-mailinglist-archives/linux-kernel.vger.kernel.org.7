Return-Path: <linux-kernel+bounces-898896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB1C56433
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F034E34731D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938D7330B30;
	Thu, 13 Nov 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6+m9Kgg"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1AB315D33
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022301; cv=none; b=do0dV+NjMjvHc/O0dq8CkpC20sMSsmaYjmJqAocwM5U29dhhi0WUpJNYgxMMEINT7EM0eI7JKy5ZidbDhPU9oMq0k9Ja/oBXfbx65XZyMeftgwwn5ODQT+L1sbApCLdfI5snCFsW5MEaQjX001uIefsQhvV7jrW22ACX2I+VdA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022301; c=relaxed/simple;
	bh=pXLpg1P+NszGM8RZ98JaLiDfJk2ejEBhbCKCWa8Wy4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jvTd+TJsQuerC49Xxu/HlzKicGPbwCjqU25scuXFaugzj9O56bvBhJtA7xhRlgL6lv8B2ULj710znopcQK6YiNpvtwVx8F1CAOKU6hcvKFdBUBLueVM68vKxzvzE6oOXKsyl5VQl5gal8AH912f+bdQLTFmucozsw4ANP1kFdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6+m9Kgg; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bc1f6dfeb3dso327653a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763022299; x=1763627099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E29I21iTFgmKy+IbzDTMyuzYhhbOKWzxr4diSFn7ScU=;
        b=Z6+m9Kgg4ATLxOnbYbxDYu3dpm05yxztNZa8oQ1pGTD3kk9DR5YRcxn4TcSSbC3Nuq
         2kI8VJTcTVuLj2N3P8x1sXf/zYvzJfCR1nCx2SIFBRTLNQBbu9NX/XaXUxR2xR/RG2eY
         WmfjJoEtBkzxY/G57J7RkhV4FaTfHYswK8/U8CFBvHeu0HWNjTTrvP95P4vZ4G5udc/6
         rTHN3A93A+CfRaX0UrD0MjqQ9intF/RYDGB2+khUaZ+9W95LU0kIzlTEi1VmnnstO+sF
         6k7WhvHAhs1JepKhG+Z4igiU9J8ZxfWXfpFH+hIBRMX3TO+t5d5ObsSOJZblvx6m+9nC
         8qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022299; x=1763627099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E29I21iTFgmKy+IbzDTMyuzYhhbOKWzxr4diSFn7ScU=;
        b=bNYOfG1tPZh8ifh77/cnZ6nMxbD3IY/qxFDylLBB4pTM9qV1BQoBd4ygzqQxS+2LDd
         yw8T0+kTdeSEwOafs7c+AYRj4/Hox2rTHrbkYMfNOfIDaYJzJsljOMYfWohcE/14Ty/N
         bBTAh0lj5xYoq4H8egeLY33NXtzPkvQFMSgV1GjVcBP/uCnIWnyAGprgTAheEwK3cx17
         WZagkiA9Tc8GOcivSlpIYhDw2V2GL7XmL/ZCVaXoSWx1Sd3NaSlmaBdfsY+/oqEOJ3gC
         xhePs1mWaAF89a4VpuPg4EDWinGgvG7ateOAPpfDcL3BR6ycLB+oaediaR/RrL6JIqmU
         IyBg==
X-Forwarded-Encrypted: i=1; AJvYcCVNdWbNgTL3pFUEjTJYbv/xhbBGYMXVLzE6BYnMFwAa5Vj43jzfl7fCnMHe18xBHr0b+FA0NNTGqcLKb/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkdo90G7YNEV48QUTLHW7WgSvyzkWntE99vi8QqwpeSQeo1uxS
	vjzTK9YRevUsuWWbajqqNeLian+CvhOTT4FYVPjghN3Diwd+FjZX1XKd
X-Gm-Gg: ASbGncvP1gtWG1Hug/aIciqxz+zjQQX5b4mHOSI5/3kzg1D0vb5riUjHPSTbtiMpBN4
	o9KkO2fOZvZr8T2+znDCtjfr6CdBvhsrEUQ/5ifI4s7MidHnbnoM2xrZZA1Nn/V0kO6Nflv2zx/
	igomC2Y5W5TkdL2iPPbftn57sTUSVYxiCCcxvLH6HQEB/h6aBmwfR/4q7bjOTKma21MOVT4Iygw
	FpB4nar7umRinMgaJ6JghoXx+/pPzpOG+yzf6TZkwQGXh6MF9SIZ44wiFBvh+JcYla1YS8rIUE/
	x9gKZRWJNzjC/rNrvRVWOREqKLNQJhT/CobVPkhm5Kvwj94nb7gzhx7xaJAvNpWIWDd+yhRI+5a
	riWm0/tLdy3zutw2xMIxzy9ZN5EHc/5ASEYm1S3kKiC/2uI/Jjhcn4Q878XggWvZ6Jak1lT1I13
	85ux+J7/r8ik26YB2Ga0WgXlriihy2iH0GCDFZr4M=
X-Google-Smtp-Source: AGHT+IG6G8bRlTc+7WY76hJfvUTnoph43OEFDRSFR5ryUFHLWUxOfe6SWPhcIlsJWUCZ9XOhzdKiwg==
X-Received: by 2002:a17:903:110f:b0:298:34b:492c with SMTP id d9443c01a7336-2984ee1df94mr76201095ad.54.1763022298884;
        Thu, 13 Nov 2025 00:24:58 -0800 (PST)
Received: from localhost.localdomain ([103.246.102.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b1055sm16332635ad.59.2025.11.13.00.24.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Nov 2025 00:24:58 -0800 (PST)
From: Alessandro Decina <alessandro.d@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Alessandro Decina <alessandro.d@gmail.com>
Subject: [PATCH net v3 0/1] i40e: xsk: advance next_to_clean on status descriptors
Date: Thu, 13 Nov 2025 19:24:37 +1100
Message-Id: <20251113082438.54154-1-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

As suggested by Maciej, submitting v3 which makes i40e_clean_rx_irq and
i40e_clean_rx_irq_zc use similar logic and a shared function
i40e_inc_ntp_ntc() to advance next_to_process and next_to_clean when
handling status descriptors. 

I've left the rest of the i40e_clean_rx_irq logic unchanged or this
patch would snowball. I think it'd be nice to change the function to
work with local variables and update the rx_ring only at the end like
_zc, but seems out of scope for this patch. 

Changes since v2:
 * use common utility function i40e_inc_ntp_ntc to advance indexes

Alessandro Decina (1):
  i40e: xsk: advance next_to_clean on status descriptors

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 33 ++++++++++++-------
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 17 ++++++----
 3 files changed, 34 insertions(+), 18 deletions(-)


base-commit: 96a9178a29a6b84bb632ebeb4e84cf61191c73d5
-- 
2.43.0


