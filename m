Return-Path: <linux-kernel+bounces-853714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BBBBDC650
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A4D404FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3B92E283B;
	Wed, 15 Oct 2025 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXbSZlaX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB191A23B9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501002; cv=none; b=bGfhIkI7u0SRzVujrlxj/kRA9dtPnqfVwdleMQXj5hAiSx/YAL9vd+9GnDENhjfu+kEcAzCmV6r49A+/Xy/GNDczIpWDxYIeVpsji/lFP2hZOQAb5zQ4lIMYR1li5mdb7yEX50VB8lza5nYKyjlFfi1PutVYyAKWDftB8zhlC+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501002; c=relaxed/simple;
	bh=p04wSVedq5RYaX5Nmz9HRn5PNrsa31BCRLo0sVIHALg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+czfl9vhpMZ6pdsyK8UZ6g0wpcXA9z+JjG0KN/aJNjumXjwP7kacDo1cntYJlSeXj3WuqcMZe2AmVq6tJNyJat0Re27lX+pNUMFgwp6nbSoPpv4x0cdgYAIdpVjtP1W0gFwx6JhRTyDswUdmlSAXkixBNEjvFDe0lY2/JVPLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXbSZlaX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760501000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F0oQPy6sJALcjkJ1xdOgR0v6F24g1cMKqTRKvMpDOSk=;
	b=HXbSZlaXoZWg3E+aqUweX1MXrHLK7Zf9igE7myOKqWGFzu0Te2nf9WtGKPeUjXnYfmNK4D
	nqKJ0OQVTfYmsEaKk5fDIPrpXrkV0YRQGPixQySz4RfDGMJLeQ3ZF1mq5ffhcLSt2vScWj
	BKva7qMbTp3EtMLZeSFMI8ji1L63Ks0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-Qt0nL0czO--71hj1IExdIQ-1; Wed, 15 Oct 2025 00:03:18 -0400
X-MC-Unique: Qt0nL0czO--71hj1IExdIQ-1
X-Mimecast-MFC-AGG-ID: Qt0nL0czO--71hj1IExdIQ_1760500997
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so16379363a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760500997; x=1761105797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0oQPy6sJALcjkJ1xdOgR0v6F24g1cMKqTRKvMpDOSk=;
        b=cZf4AGp2xgaSHvuF6VG3ZBbenVZmIAb0/rfk4Ig5VR0wqTLAjXrLcSANq64vc0oa/I
         Z9x4OmRKsuVQQZZelD2z0ZCq3WOOIzRvy8alUfzaGO8tndBj5YupmRjSwXIfarwLWZwO
         qECB/eOV/pLnXcbl27a98pzRbthHlcf1bj8bGvEg1eTnVV2Cb9G47S6jVF5CNzbjmE2u
         ilO8H8GVaY+1KwI0ldSUG0PpQoWLCZafQoriZigYBba8Z1X2waX6kM4LHiIuG008oxmk
         3ZCDXqkcaVpp8rNAEk1PKKezf+RUhstn/Oc3piymoYimEaOiLQhvIMz+9alRN3nTBOP8
         yAtw==
X-Forwarded-Encrypted: i=1; AJvYcCVlI1mB2nKzIq3m2r4DG7327na9yT4LGEEgLvHdt8CHBRNJqmVWnHRvNqvUu/PtruqddRP+1H3SBxnVpEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxKfUcSgFULv4qiF5KBmuPclTgrXvKjKS6XVOgbB74ixbQHe0d
	p7qfhMwu2Xia0Qf/Cchgt1dPW6zqyjupUZQ+0OlHrZB2WDp39eE5GCTtDAvOG7eiBiU6phg6pMq
	4fuehO1c8XBfz2fHW7fGicNg95u6epKAGp1rtorbIh9BE/+ZvGaIyekVYuLNtakjwZQ==
X-Gm-Gg: ASbGncsHRgMG9LDhQcftwqaLS1dCIV/000qsOo8NOOJUh6+ckw5ll3eMthGgMp6s8zG
	EQKHxn/GLoY73QOHQY/buNsAaWDHL0FNhaHgXShJl11Stx1pIsp9o3dA2dtxPUzcTkQa/qMLlgZ
	N+wbQ1B3nCApK1HymBILxb842eAxYZiKQxLM92QgvCwc2K8APbwc5vkW84hsgSjYfZBVMMfRQlh
	Z7by3yJG35G2ufTHC40vtv4tPulkeJS9rUFkBU/ikpSIw+zC99iFVhqoenGBoVP94i+Xo2Tg6Pa
	KT6bdRJAhV5ZmhfpRo6asKFUuahj0KX3Vrw=
X-Received: by 2002:a17:90b:1806:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-33b513cdaf5mr36389070a91.27.1760500997141;
        Tue, 14 Oct 2025 21:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRFuxW1Voy1mECvxyxh5CgehQPp4dDoRICc/mU73XzzKeQ5F8jWZeJJVvKmOuyelAlOt4irw==
X-Received: by 2002:a17:90b:1806:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-33b513cdaf5mr36389041a91.27.1760500996718;
        Tue, 14 Oct 2025 21:03:16 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b978607cfsm608006a91.9.2025.10.14.21.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:03:16 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH rust-next v2 0/3] rust: miscdevice: add llseek support
Date: Wed, 15 Oct 2025 13:02:40 +0900
Message-ID: <20251015040246.151141-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series add support for the llseek file operation to misc
devices written in Rust.

The first patch introduces pos()/pos_mut() methods to LocalFile and
File. These helpers allow to refer to the file's position, which is
required for implementing lseek in misc_device.

The second patch adds the llseek hook to the MiscDevice trait, enabling
Rust drivers to implement the seeking logic.

The last one updates the rust_misc_device sample to demonstrate the
usage of the new llseek hook, including a C test program that verifies
the functionality.

history of this patch:

v2:
- Introduce pos() and pos_mut() methods to get file positions,
and use them in sample programs.
- Add read, write and lseek in the userspace sample program. 
- Remove unsafe block from the sample program. 
- In this v2 patch, remove SEEK_END related codes from
a sample program because it needs inode->i_size which has not
implemented yet. The purpose of this patch is to introduce
lseek(). Since implementing an 'inode wrap' requires more
extensive discussion than adding llseek hook(), I just
exclude it from this patch series. I believe that whether
SEEK_END is supported or not has no impact on adding lseek()
to MiscDevice.

v1:
https://lore.kernel.org/rust-for-linux/20250818135846.133722-1-ryasuoka@redhat.com/


Ryosuke Yasuoka (3):
  rust: fs: add pos/pos_mut methods for LocalFile struct
  rust: miscdevice: add llseek support
  rust: samples: miscdevice: add lseek samples

 rust/kernel/fs/file.rs           | 61 ++++++++++++++++++++++++++++
 rust/kernel/miscdevice.rs        | 36 +++++++++++++++++
 samples/rust/rust_misc_device.rs | 68 ++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)


base-commit: 98906f9d850e4882004749eccb8920649dc98456
-- 
2.51.0


