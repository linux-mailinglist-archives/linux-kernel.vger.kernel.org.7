Return-Path: <linux-kernel+bounces-821819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20212B825E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE206723880
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA919E819;
	Thu, 18 Sep 2025 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3l+CyN0"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520B211C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155086; cv=none; b=osXa87T16JtkBR8fIeNU58yCZeAdfleGXJ8HLTFdmdD3kEqx2KKXRp45wEuVrhPA1lY0w6e2sAxNwEs5DkK6CD+/F/jFl1OWg8YZehTWrzyVTy73NemVVP58tXYIluya6BLEFdQVYjEvydIXC6NSGDI201x7mDLX1WDO+mAWXtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155086; c=relaxed/simple;
	bh=aqa3HyW4izEedzN2M7rAgsR/LkZTNRFE/QQpCiqhopE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dzSGidP6q60aVI4blS6tJ6RCWQF0VaBbMz8lv6JajcTI7AbGJm/z84z+APdzJEYpnezCqrZYPtNAivnyuQRDheVITfvuUrEH/VZta++wwTGXrv+soTFg0yL1VRQ57Vgs/YutjnmUvOytB/WxZ9WZ+lj/rIjgSx5O+SPuVWXpVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3l+CyN0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b7abed161bso4669201cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758155084; x=1758759884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AAXfVbKrj81Yrvk5S99ka61ApJPAF5+mvHdEE3dMmkE=;
        b=H3l+CyN0+X4DRDmDvIeMO8W26J1phrmYxGauoc3V//ih0oCsyVw3aDQbq9kWcDBVh5
         so8lJ8kSahN+2Rgi7WzTK5lQfJtlHcbnMwGylb3iMQnj9iQ2YlxaIK8/qEa2Ye155UAM
         U0TPIS2V5I9fl8njAXsty7esJQsX0+MP6vOg1M4cmbeBFbxWg39LzxRq2Jh5ClRV8VYV
         QjTMnfArEMVnH4ou1NWEvksvUJ3gAOht1XUhl+gArp26uC2vb7BpwReK787MkNmz7iSq
         XQTM+hIYl/8n/QbC/aAvdikoWdDEMisAPF6oyTaMCAppeHQfdIdGuneePbw/vjgL3WmN
         IEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758155084; x=1758759884;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAXfVbKrj81Yrvk5S99ka61ApJPAF5+mvHdEE3dMmkE=;
        b=VDhqiD9fHWHMkX17KGzHu4TpdgTCgiHUVzA0v9aqhH8AQnqlReyqGfkrytdGCjtk+v
         QPq9L629Pa9MyZyvvVirZKAK1qC4FujQkF5B3vyGPE8Py7quxa3Xi3KxQpaDdp+HB/ff
         jtWYMzfA09xhV6DH0rb72TtNc3thVnLvSTthXTiWwa99lMHXwKPxa++mS7+B5PvZiFND
         BqL2beR69tsbHCV1yghjKUtaBEQcatBMpgWHZmjAfFabFrb7iKEKXDFI4suIGDBxkhog
         XQtRPp59cKvLgIhbKLPD87ZHWGmYzDfeVndl54Q9bYwQl0V7DMeASbyFYBX/OZ393G5u
         2P9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2wMvXGaw79kPQYULCGOhttgqrCJnRCZ1Q8PwqDwS1AkMMFGgYXv23daniCRDADkN3Kisnox1A+444tkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEs1IHAVEnis/x7jhJrhSX9B81UqAhbE4Ej2ZLQw2f34wEfQ0
	7/KYD4Hd69inSL+lgbcj8ylwQLBoGG/ZttnNJCst4mDDMwMruPNLeSWv1OCMy0r6mbWZxJCoB/c
	+P7q+mQF9RuK+42tnp6WAo2bcmeSQA08=
X-Gm-Gg: ASbGnctSGNP6/xMq2x5IJ/gDRYbUaSnIOaqF5RlWiDER5BvpFBx0K7Jtjonq8DCFRfe
	mebUDXtxRHOod+CE7FEtO7X2q0nT37WfOwc3FGd769NCafgK36a83oKZ6SnbXCjh4rJnu729tuY
	EsfTzxrHw8gAgpX1AEpvnHjWVBR4fGy8V66ggOSDdjPIUQeKje1OlvU0faMIC9KMIbP5NOjLfDY
	yI4bCgauZwo5sEF5mG918T52Y/feb/Dxq0uNkfL4rFfKp58RBO9PFDOs2kiAlDd+QvsrUh84/dk
	fHEbXvXxoFnQMYD4Erq6+Y6s4xlQBrx+VlyCP4K0QfVFdBjfjUHYvVxvzg==
X-Google-Smtp-Source: AGHT+IGUH+Vo5ah/BOcidk5QhkanPaPPGQuYC3QJ2qzogXag5pL1GyIB63O7MImSt5xi0DjpoDoPL0PfcM83Oi+Oc3w=
X-Received: by 2002:a05:6214:412:b0:782:9454:ac8a with SMTP id
 6a1803df08f44-78ecf4fdc10mr43901236d6.57.1758155083710; Wed, 17 Sep 2025
 17:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 17 Sep 2025 19:24:31 -0500
X-Gm-Features: AS18NWBPu6sGfW3hnPreMxF2wFj2Jem45fHu6Sahx8yNzeyFoZ-xTePQClKaY-I
Message-ID: <CAH2r5mveqnRsJ4Fi8pQjTY2WrtDbys1f3JPR+OR=w-eskUoiyw@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, "Stefan (metze) Metzmacher" <metze@samba.org>, 
	CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.17-rc6-ksmbd-fixes

for you to fetch changes up to e1868ba37fd27c6a68e31565402b154beaa65df0:

  ksmbd: smbdirect: verify remaining_data_length respects
max_fragmented_recv_size (2025-09-14 22:17:10 -0500)

----------------------------------------------------------------
Three ksmbd fixes, all for stable
- Two fixes for remaining_data_length and offset checks in receive path
- Don't go over max SGEs which caused smbdirect send to fail (and
trigger disconnect)
----------------------------------------------------------------
Namjae Jeon (1):
      ksmbd: smbdirect: validate data_offset and data_length field of
smb_direct_data_transfer

Stefan Metzmacher (2):
      smb: server: let smb_direct_writev() respect SMB_DIRECT_MAX_SEND_SGES
      ksmbd: smbdirect: verify remaining_data_length respects
max_fragmented_recv_size

 fs/smb/server/transport_rdma.c | 183 ++++++++++++++++++++++++++-------------
 1 file changed, 125 insertions(+), 58 deletions(-)

-- 
Thanks,

Steve

