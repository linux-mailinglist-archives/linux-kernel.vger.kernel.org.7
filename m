Return-Path: <linux-kernel+bounces-825179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E379B8B2F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50089A0405E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24829B22F;
	Fri, 19 Sep 2025 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZykDN+ON"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3A425DAF0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313370; cv=none; b=bn3yAVLqiohHnnJw3ZyLZyafHVJR2A7/H2v+tY9O73STdxT5q2l6MwzQAqaTZDs7AavgqBwZeo9nyvpDHWVPl5H49KRsOsfnwkH+NEKqPZycCh9CJcISxqrcvhrx5jClo8Mns+f/Tv+Kwm4j03IgKi5RAE9B0n5kplIrokKNcAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313370; c=relaxed/simple;
	bh=rmCarrm6/v36sWR5R5CvJ9C5raSkdoNouVGhkwQpN3k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rU8lbxeRSqRz1BduK2pW5lhhFBIbC0onpEnB08ulgCCH31ifaMndAI9Tsu/fwBLxJlhOF08Ug2OicX9lRUNxfySw+gCc/JulIEVdxcEDAtdGsiJkTZl5B8NC8zsy2NcMjmVdBhzM5SgkibiBMJsLwDmVM96WXRrHwGwq710uT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZykDN+ON; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78f30dac856so29410826d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758313366; x=1758918166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Cy206vdHXoNwug0xkOGBRn67z0vWl3+IUBx20uq9Ok=;
        b=ZykDN+ONryel5Vhd4kacbsQLcr/qSwC22938iJ9zWRy8+48r/0VtWnq0JaPB/22IC0
         DEe9qXlCRvsbntsYVsIN67V+j+FpmHukGfgpUvk979KGL29sx4rK5fcrVSuoqnn00fVS
         XA74KN2F8bKPwAymP6q9hy523q68pf16K5++xvRFWGwD97ZMfDY3VKsYn9JoH66QTjxW
         lRLmnwce5Cnn0Qh6RZX4wNnjALMlaRylAwNfxqCwInanmuzcukdqNzH+jmHRfNqepnsj
         fB3sXppIyb5brl5RVVV2gHKAYsJbX4yKCrC0CYM68lhwuBoEOhNsX/wPENsmncJ3MfHK
         Im6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758313367; x=1758918167;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Cy206vdHXoNwug0xkOGBRn67z0vWl3+IUBx20uq9Ok=;
        b=c3p2hTFS21VtE9K+CqihKi/oo8Ey/Kovzgemw6JksP0WWNFNqz5BqusdXW01ao/X8E
         5gezXsINw0G8cp2a/xQy0o+yqCaKW1cl1/V3KMZeZ/XHeFQqvKrMKpTC98jT8GRaSw19
         g4jtssFlyk0cMhUw6ZA7cZWM81BEhHQOj6spl/wEn4vGHWiD40Ao9ovhHwp9sUtmi2G7
         tvDt5BjnlFyrEL4h8SQyIL76KzDsmpyq+jUjr4XpGKSfzt+LAFNoK2Gpq38G27qTqbFe
         tGvUPt1ZV6UqO3pvsL8E1Kg+Yz6aEY/QCdCrZddZsh8/OPA+v9ORQ1SfkESfIr97Ue5N
         zS5Q==
X-Gm-Message-State: AOJu0YxUw7VxxKhzaVt24pFBUWG7q4NDmDQcrt9Kc5vOrSAO+FSTJKiP
	Rop1XMHrwhOWhDuQlYKTyKeLMu4WP5BboiuJNdFdczb/KoRNFEsW+Uw7X0fmDjM1Qc7+xsOg6YM
	cX8VvSO/b5K6+v6zdgoLFVxXMxRhgcXs=
X-Gm-Gg: ASbGnct2JITGe6aRu+vkyZmkCvVsZxhp1vigPM4iN1+sJ5HST02J7hw3eN5MCg+cpDc
	FdvJt/6iqTg8yOjZ6Ecuvskk8FlGmYFovHKUAIjKYIqhf+k6HLr7tOgVLNElvx8+46eLjnnU96V
	GA7Kp0l98frZTbmsHBEWQ/mA3vfe54A9QvVgHcWeTUtjKt7Op5fDxARjeE+cSpYZaNlciCCCn/R
	mqwQ38KYcsgvDi6EeW424QNP7AUpfa/oiynsEvbOf7ImNHU/ayuzXOOtNHL87zbXfT77yhd7wns
	NvpRj+lh00dDinQXhMdwRQ6psBlAOV8sF1yNg+75pzZ//0QJWQLCWVMBaWITU8SbGJoJtiZwKpQ
	68a5ddBFknptLEQRO5Qv6sQ==
X-Google-Smtp-Source: AGHT+IGGImSU6vWX0E3XUBvl/H3q20vO7+Ak+1/XGT8LNRyvVP3NfjlHzlDkQ71ErIMJWhX6XIsBjifr13dctqtG2oY=
X-Received: by 2002:a05:6214:226e:b0:741:52cf:a104 with SMTP id
 6a1803df08f44-7990fe38074mr52494986d6.5.1758313366488; Fri, 19 Sep 2025
 13:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 19 Sep 2025 15:22:35 -0500
X-Gm-Features: AS18NWBD_WBUHdrEHM7UxAsP6qhd4g7AA9UdPCh_tSXfbHcTmH08YWsTsHv20zk
Message-ID: <CAH2r5ms1vdZHKz4guZFpR0fMfZFE36eBwdH+fapaW-i1tOTSaw@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.17-rc6-smb3-client-fixes

for you to fetch changes up to daac51c7032036a0ca5f1aa419ad1b0471d1c6e0:

  smb: client: fix smbdirect_recv_io leak in smbd_negotiate() error
path (2025-09-18 16:46:04 -0500)

----------------------------------------------------------------
Six smb3.1.1 client fixes, all for stable
- Two unlink fixes: one for rename and one for deferred close
- Four smbdirect/RDMA fixes: fix buffer leak in negotiate, two fixes for
  races in smbd_destroy, fix offset and length checks in recv_done

----------------------------------------------------------------
Paulo Alcantara (2):
      smb: client: fix filename matching of deferred files
      smb: client: fix file open check in __cifs_unlink()

Stefan Metzmacher (4):
      smb: client: let recv_done verify data_offset, data_length and
remaining_data_length
      smb: client: use disable[_delayed]_work_sync in smbdirect.c
      smb: client: let smbd_destroy() call
disable_work_sync(&info->post_send_credits_work)
      smb: client: fix smbdirect_recv_io leak in smbd_negotiate() error path

 fs/smb/client/cifsproto.h |  4 ++--
 fs/smb/client/inode.c     | 23 ++++++++++++++++++-----
 fs/smb/client/misc.c      | 38 ++++++++++++++++----------------------
 fs/smb/client/smbdirect.c | 33 ++++++++++++++++++++++++++++-----
 4 files changed, 64 insertions(+), 34 deletions(-)


-- 
Thanks,

Steve

