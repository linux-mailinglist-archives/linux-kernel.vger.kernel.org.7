Return-Path: <linux-kernel+bounces-879541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE2C23636
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A444E3A8AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435B32F4A15;
	Fri, 31 Oct 2025 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiLgcD4j"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C15A2F39AD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892087; cv=none; b=Cxov+sRKQk5UppkyOphN7ctmxH51vFKA746SrZeyU8HFbEvPzOCQPZGst3BzWDLL1Rayu7NWIDtnxikccyT0y0g5KWc6LKvUr+TDSdz6kZwaZzGKvQELPX3S0Tubkhshg+P64AW9BFD01NCKsCi2U1/8ZaurGvVjClYq6ScmY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892087; c=relaxed/simple;
	bh=jrd2tIR5wyqs3uwdE9Zu1dAgvEi/6nY3qNdhl0FdQP8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lpR91NzWWPslvp40z8MwwJTkH1QZL32aOKdcfq8A2+prnSp4EoI0R+AuU1aUOORouoFETY5AvmkNPkY7RTaDGlk5SVAg4hsW7KBAAGMD/65RX1IrtMAZmwarOZByxXLqZhoNIYiJtGRG9XftRlCxN9zV27oF3Qp4/5I5nobPQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiLgcD4j; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b4f323cf89bso437649866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761892084; x=1762496884; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FkzRKxvnInQ+Pna50TQKEBhs0Uzk/Cf1y5QHnULHQhs=;
        b=NiLgcD4jEiFRRftvYt5JY3ufLlRq237UPdWNu5hIZ2m5mNiRsgy9BTQt9QYKXuhw/A
         wRKaFfqMKSO0GQz74KKXpuNXpEvzvY8Sjf6MB8M+n/shQKlPGLT+UnmfMh6sUqLsP5Dx
         LY2rfWc78aNDW6jdoRuZJOSeaiNBMw/0whkwe6B7PGeoHQ13DPlyx1eoiXQTJmaWCCxA
         NSOox9j62zrqJBOSL/9WBKt8lIuLvCeBMCcUWDMQjVzOhByUKdAsKDgmkb7/dOnY0TR8
         I0fA5gXXQoUkit8lb2bPweIpJKbaEt/FakdiGeBi/tUYm6Kuie+DRlSKAmPC2XO15is8
         4LyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761892084; x=1762496884;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FkzRKxvnInQ+Pna50TQKEBhs0Uzk/Cf1y5QHnULHQhs=;
        b=YQnVbCMBj8xGWWEfJSaLR1M4GCzAiqWcygWj8Fo5M8VyNuQNjdETRRmdFERcLxCf6V
         PZ/ywJpZsELuzN04lJCArRSMc0Vb+kJf0CiTgftdPgRo2lCeLxkmNaL1lWrsifCav6jf
         UuTnlYY7V7EH2RWsWfZ9NJhXqq7wwdDWVxVBaiIIgf0TdiXR5gETWtxD0WVvyEK1tyB9
         uGA/QUILUsClRgJqTunMbwva53/v/WaUYgrxTqp6GMNaJeAvBAyS4Q63GFc9RGGEpT8n
         W40h7jOFcg0eUDnC1CDHv0Kxh8k3zU241IU1/hoYDn2I1PrAgyhOGTC4/1BKMsvPnUYG
         v/nw==
X-Forwarded-Encrypted: i=1; AJvYcCWF18i1o6FxepzewvOWlzUjXKx4Nw/zi8kwZgAVmaWAe9i5quLKw7rHJ2pBRWu+QvO6WOESHCxeyI8XHqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdi9m1OuTek4hEle4AA7x5GmKwVZWeYuyTehaAzz0MNcqEQcCM
	Zq0c8ruFQRm/J7OnivUPdpsvTjPFFsF9WmPpUT7ThnhnZy7tXB/YpSCHczNWrSaNFBNymmLwxFe
	bYHLET1sR7lbjaRr32JtXxbe/sP6TLHc=
X-Gm-Gg: ASbGnctbMz141UG7y4gmLLuGQZnqOnVrotIR85TMy9sPGfDzm/OYEJL7VukPdOrQNzM
	fHEPx2hIzn72+ekOcFJo7+2KXDFpjPBnrbJgj35Xr6SPkRxU26/iGMhUBPL65YUcVYbd8hdQLHJ
	NajZs+p3LyD8FVnTccaXl4UHnByGY6AewKet+zhw/avld8Gx6cRSkrCcb8wlyFdNE/THuBc1HPQ
	lj/1eTAjYAVxCfvFVQqzqQ0GzcY7K7dyAJvp9GODh/hgAJpIpND3oPxAY7r
X-Google-Smtp-Source: AGHT+IGt/UGVZHtUO7REa4xYMHZ33NQF7v8PXK46TsZegrZfRdQ5rR3ztcRH1AwzSV1caSxGfpUt+IOiwQOq6oKNBZ4=
X-Received: by 2002:a17:906:fd87:b0:b6d:6a35:9996 with SMTP id
 a640c23a62f3a-b707085cb9dmr239150966b.58.1761892083631; Thu, 30 Oct 2025
 23:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Shi <seakeel@gmail.com>
Date: Fri, 31 Oct 2025 14:27:26 +0800
X-Gm-Features: AWmQ_bl4h4hHHMs-mhWNLdRkxc9e7lEmundpZ0yE_sRAPX43rVrzOD8BHUQ2PeU
Message-ID: <CAJy-Am=qL9xYM-q+ciYfhj2ez-8Go8W19mNxXwOxZT=4=wT_4g@mail.gmail.com>
Subject: [GIT PULL] Chinese-docs changs for v6.18
To: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Dongliang Mu <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"

The following changes since commit f44a29784f685804d9970cfb0d3439c9e30981d7:

  Documentation: update maintainer-pgp-guide for latest best practices
(2025-09-09 13:43:55 -0600)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/alexs/linux.git
tags/Chinese-docs-6.18

for you to fetch changes up to 6fc05a144c12305a54f1707edc407d4137fef742:

  Revert "Docs/zh_CN: Translate skbuff.rst to Simplified Chinese"
(2025-10-31 14:01:35 +0800)

----------------------------------------------------------------
Chinese translation docs for 6.18

This is the Chinese translation subtree for 6.18. It includes
the following changes:
        - docs/zh_CN: Add rust Chinese translations
        - docs/zh_CN: Add scsi Chinese translations
        - docs/zh_CN: Add gfs2 Chinese translations
        - Add some other Chinese translations and fixes

Above patches are tested by 'make htmldocs'

Signed-off-by: Alex Shi <alexs@kernel.org>

----------------------------------------------------------------
Alex Shi (1):
      Revert "Docs/zh_CN: Translate skbuff.rst to Simplified Chinese"

Ben Guo (2):
      docs/zh_CN: Update Rust index translation and add reference label
      docs/zh_CN: Add translation of rust/testing.rst

Shao Mingyin (5):
      Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
      Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chinese
      Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
      Docs/zh_CN: Translate gfs2-uevents.rst to Simplified Chinese
      Docs/zh_CN: Translate gfs2-glocks.rst to Simplified Chinese

Shuo Zhao (4):
      docs/zh_CN: Add security ipe Chinese translation
      docs/zh_CN: Add security lsm-development Chinese translation
      docs/zh_CN: Add security SCTP Chinese translation
      docs/zh_CN: Add secrets coco Chinese translation

Sun yuxi (2):
      Docs/zh_CN: Translate mptcp-sysctl.rst to Simplified Chinese
      Docs/zh_CN: Translate generic-hdlc.rst to Simplified Chinese

Wang Longjie (2):
      Docs/zh_CN: Translate dnotify.rst to Simplified Chinese
      Docs/zh_CN: Translate inotify.rst to Simplified Chinese

Wang Yaxin (2):
      Docs/zh_CN: Translate skbuff.rst to Simplified Chinese
      Docs/zh_CN: Translate timestamping.rst to Simplified Chinese

doubled (7):
      docs/zh_CN: Add scsi/index.rst translation
      docs/zh_CN: Add scsi.rst translation
      docs/zh_CN: Add scsi_mid_low_api.rst translation
      docs/zh_CN: Add scsi_eh.rst translation
      docs/zh_CN: Add scsi-parameters.rst translation
      docs/zh_CN: Add link_power_management_policy.rst translation
      docs/zh_CN: Add sd-parameters.rst translation

shaomingyin (3):
      Docs/zh_CN: add fixed format for the header of gfs2-glocks.rst
      Docs/zh_CN: align title underline for ubifs.rst
      Docs/zh_CN: fix the format of proofreader

 Documentation/translations/zh_CN/filesystems/dnotify.rst            |   67 ++
 Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst        |
 211 ++++++
 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst       |   97 +++
 Documentation/translations/zh_CN/filesystems/gfs2.rst               |   57 ++
 Documentation/translations/zh_CN/filesystems/index.rst              |   17 +-
 Documentation/translations/zh_CN/filesystems/inotify.rst            |   80 ++
 .../translations/zh_CN/filesystems/ubifs-authentication.rst         |
 354 +++++++++
 Documentation/translations/zh_CN/filesystems/ubifs.rst              |  114 +++
 Documentation/translations/zh_CN/networking/generic-hdlc.rst        |
 176 +++++
 Documentation/translations/zh_CN/networking/index.rst               |    7 +-
 Documentation/translations/zh_CN/networking/mptcp-sysctl.rst        |  139 ++++
 Documentation/translations/zh_CN/networking/timestamping.rst        |
 674 +++++++++++++++++
 Documentation/translations/zh_CN/rust/general-information.rst       |    1 +
 Documentation/translations/zh_CN/rust/index.rst                     |   33 +-
 Documentation/translations/zh_CN/rust/testing.rst                   |
 215 ++++++
 Documentation/translations/zh_CN/scsi/index.rst                     |   92 +++
 .../translations/zh_CN/scsi/link_power_management_policy.rst        |   32 +
 Documentation/translations/zh_CN/scsi/scsi-parameters.rst           |  118 +++
 Documentation/translations/zh_CN/scsi/scsi.rst                      |   48 ++
 Documentation/translations/zh_CN/scsi/scsi_eh.rst                   |
 482 ++++++++++++
 Documentation/translations/zh_CN/scsi/scsi_mid_low_api.rst          |
1174 +++++++++++++++++++++++++++++
 Documentation/translations/zh_CN/scsi/sd-parameters.rst             |   38 +
 Documentation/translations/zh_CN/security/SCTP.rst                  |
 317 ++++++++
 Documentation/translations/zh_CN/security/index.rst                 |    4 +-
 Documentation/translations/zh_CN/security/ipe.rst                   |
 398 ++++++++++
 Documentation/translations/zh_CN/security/lsm-development.rst       |   19 +
 Documentation/translations/zh_CN/security/secrets/coco.rst          |   96 +++
 Documentation/translations/zh_CN/security/secrets/index.rst         |    9 +-
 Documentation/translations/zh_CN/subsystem-apis.rst                 |    2 +-
 29 files changed, 5056 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/filesystems/dnotify.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
 create mode 100644
Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/inotify.rst
 create mode 100644
Documentation/translations/zh_CN/filesystems/ubifs-authentication.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs.rst
 create mode 100644 Documentation/translations/zh_CN/networking/generic-hdlc.rst
 create mode 100644 Documentation/translations/zh_CN/networking/mptcp-sysctl.rst
 create mode 100644 Documentation/translations/zh_CN/networking/timestamping.rst
 create mode 100644 Documentation/translations/zh_CN/rust/testing.rst
 create mode 100644 Documentation/translations/zh_CN/scsi/index.rst
 create mode 100644
Documentation/translations/zh_CN/scsi/link_power_management_policy.rst
 create mode 100644 Documentation/translations/zh_CN/scsi/scsi-parameters.rst
 create mode 100644 Documentation/translations/zh_CN/scsi/scsi.rst
 create mode 100644 Documentation/translations/zh_CN/scsi/scsi_eh.rst
 create mode 100644 Documentation/translations/zh_CN/scsi/scsi_mid_low_api.rst
 create mode 100644 Documentation/translations/zh_CN/scsi/sd-parameters.rst
 create mode 100644 Documentation/translations/zh_CN/security/SCTP.rst
 create mode 100644 Documentation/translations/zh_CN/security/ipe.rst
 create mode 100644
Documentation/translations/zh_CN/security/lsm-development.rst
 create mode 100644 Documentation/translations/zh_CN/security/secrets/coco.rst

