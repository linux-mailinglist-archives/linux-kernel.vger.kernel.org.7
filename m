Return-Path: <linux-kernel+bounces-898654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1999BC55AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 604D934CC93
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29D92FFDDC;
	Thu, 13 Nov 2025 04:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKCKTppC"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5C433A6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763008787; cv=none; b=RmVtxYTulLbz1TRji0Y6dn1NBTRprqHg44k92ld83weAqaeH9ORmKWwBBfa2unj/6SY6oBg3+7Fk9csi9QF2knPB1AGu3OItagehWMSYEqE3O0ddG8tNlOr73V9f3OG+HyCbUzgr0leEqA5kBHnl7bjtDNx/JS5ywK/Rw9WR0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763008787; c=relaxed/simple;
	bh=8PE/5UQ+uNe5danCCBOkdV9a/gHHtnO41yR+Z+8vF9c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dUCg+lLUi7jgwuTLt0+3kf4s2oGmIvR81Ww9qVsW86lCRw9vq9hw1BfWV5jCO0BgSesr6laEkjbcMtbvWoK0zoap5psKZ2xM6wrZ13OImFD6pfYv9E2eX8OlbQ1SIwi4UZbu/vdZP+gg0i0sUrG2Xs/etieahUffXJ1qjWtAlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKCKTppC; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4edb7c8232aso5397281cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763008784; x=1763613584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nS1Fb6GY+hcNWo43ARgi6gCvS6V1xrWZtXSBcti+qYA=;
        b=TKCKTppCSwCsllOXmp+xW40ejn0s1bjOGOAAZnNus9cr8MB0XsKTRQGNBvCrsK9nv8
         XeWiETpruJooaY17aBdA3eHHcKhbXcHYltj9zX4kQ0mV815hN5aIYSDo4lkBdJNzFZk/
         6HDGcbgJ0SAKQFqB6txgVzacbJpZhUV5VAcdy9h9PUCbcSpsfvrBJSkXwmB0hBUq+RdR
         c8dBIHqai+HztFx4jXBqyYWjfezTDsU5YjZsvMj6VHAKEzOouJxFwgSdt4v4nAXwwXdZ
         93woQv6U+aTbeI2jO5Pr5jXUBmSbp0qsY+I5qGydyjqYZ7t4EWUzHEMzie/igE3kuRY3
         7+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763008784; x=1763613584;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nS1Fb6GY+hcNWo43ARgi6gCvS6V1xrWZtXSBcti+qYA=;
        b=rtlgx0jzNTF6Hd/s5hlefpJwUxKniUnIbW6HFgkN14Yo0IHAldZiRCHRuiWma0C4D+
         pi0I2hXID/W2lgUyEoQZM9pRFKjVb28tZxmUWOoZiZOtB1f599x19uUWQlKcQ4Q8SbuL
         TOf/d6y++aE1nKeUtaeNFbT45/wV91WHTDpZZrXYKP8gsOz91pmuCUdWkXi8nGXGfhHt
         o/3/EyrnBMfT6165n45slFP3u/OSTFGX43RcN3P38iNbvwhJd4t51CF4PYt44eF8uFSg
         4J83Smj3Lm8f06HjtkeiQutXYht5H0s8H3YsAXxWH0QGq8Fgq1z1rWoo4ge7nHU79FSA
         OrcQ==
X-Gm-Message-State: AOJu0Yw7vsHT/SarrMGFZEjAT4V0zZe5NHbDSWFYmv6d3T+C4mBziXLT
	qlc7uJCrCi2QpnwCanVwm/iKtor06ig5xxBjX36LRvuQLwOc4ND9j9cjcYwVlKhnpfszjRkw8XQ
	M8kc/6E/i4PfqZuCim7JRFZj33gH6lbU=
X-Gm-Gg: ASbGnctDnyJN2wPozTWCF6GGlU9tn6bBIDjUmp2wxAwKqtoTXQQPEHhgzfvCcV5IbGU
	zW+eo7OqIgvfiSYbv6f4VMsx12woSRxUV+f8WkvMS4tbD3lDhNNp2OippVKHf9oQz9k9bkGJ3wx
	XpdmVhK7VtH6uKlk/hPaPjxLT1EC93zv+R0AjwtVo9IegF+JgLUBT18jUVNj+s1rVOfMHARl5uZ
	7ZJK1TvNF5l5YoicS4ZSpu0m7oHlYc3N+0lnANqMXUFQcoyQ02mPK+uGllSPQWFDMpUeMm/KnoB
	i+6TQ0KU/OuKv3rLW/J251qIcOuy5CA765tkU5lTuNPlHW0bcgVPUv1DCTeU4SWtIjdefboN31y
	zfio0oc66cb66FUocMd/rBKPw2NZR4dQGGj1bPUONh85Gruq5
X-Google-Smtp-Source: AGHT+IF/HFdvvnrQstUYL2HuKqJQana16mxr6VqWpNpkevQWIOl9K20sZHhgiPfXNxPJU+XnOgrH/DPNQqHwHB8DZKc=
X-Received: by 2002:ac8:5d50:0:b0:4d0:ac40:fab8 with SMTP id
 d75a77b69052e-4eddbc6aa3dmr79240981cf.7.1763008784515; Wed, 12 Nov 2025
 20:39:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 12 Nov 2025 22:39:33 -0600
X-Gm-Features: AWmQ_bmA8jjlgRZ1SJQzNksGaq_SRIeKXPDybLTOtBvuiJNrv9YIYy_FUkSQTlE
Message-ID: <CAH2r5mt03Ds=Fcbn59XO+9Vy6SVpeQ4DvcUzu-gA4-=gw5A2nw@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	"Stefan (metze) Metzmacher" <metze@samba.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c:

  Linux 6.18-rc5 (2025-11-09 15:10:19 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/v6.18-rc5-smb-server-fixes

for you to fetch changes up to 55286b1e1bf4ce55f61ad2816d4ff8a7861a8cbb:

  smb: server: let smb_direct_disconnect_rdma_connection() turn
CREATED into DISCONNECTED (2025-11-11 09:50:35 -0600)

----------------------------------------------------------------
Three ksmbd server fixes
- Fix smbdirect (RDMA) disconnect hang bug
- Fix potential Denial of Service when connection limit exceeded
- Fix smbdirect (RDMA) connection (potentially accessing freed memory) bug
----------------------------------------------------------------
Joshua Rogers (2):
      smb: server: rdma: avoid unmapping posted recv on accept failure
      ksmbd: close accepted socket when per-IP limit rejects connection

Stefan Metzmacher (1):
      smb: server: let smb_direct_disconnect_rdma_connection() turn
CREATED into DISCONNECTED

 fs/smb/server/transport_rdma.c | 14 +++++++++++++-
 fs/smb/server/transport_tcp.c  |  5 ++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
Thanks,

Steve

