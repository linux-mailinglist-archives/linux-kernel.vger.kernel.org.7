Return-Path: <linux-kernel+bounces-853781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053E3BDC964
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40BB3C762C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C52302155;
	Wed, 15 Oct 2025 05:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJV9/nFd"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8E301706
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505415; cv=none; b=CfbPjH8JlKOugQd9nxdopmNQnSn6DdSuAuWjk+NUdqAd5aI6o1VoWPdkwf6E6kRImKlJCoaR37kPOyX92UPPH9WsstNowE9eX3c4aniiCkViaFzW0dkVTos0quA8rMpEHjnGNt5JjzcfUwbjrA5MhWpcFt/VuhVHXDetmXukRF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505415; c=relaxed/simple;
	bh=ZGjZ/MXVdEJF72fYcarWQaP0NzCcNsyU/SpwECUVcMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FkHpL+AajAH2gflj25Jv8uDDw11acJ1pYxAttdwVz/+M6IvF+vnZxZKaTiDaBOTZN1bQ72mNMLK2T9G/eUd//JySNtH0fUVyK7Ol1e/+FuZaMhk34bIxP2J8x7AJ+9l4vLY3ZvU+6onFSaXQd7M1m1nZjl+NwuQdC0PyY1udd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJV9/nFd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-796f9a8a088so5849322b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760505413; x=1761110213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmdk0eUxok1/vVVsxuT3HWDsufBCi+dhI2wWj0KYVpc=;
        b=nJV9/nFd1UqbnGsDx83xsaWSnGZjG6vUohEUJvj9trtKqzH3fjC64Jq4Ykl6pdU21J
         nvZZDaQRD7FiLcYRhyCetTEMfa9p6rdw0BCm5sIeFh7UVQ3O5Et5Susi047j5a4pR+uR
         X4rRuUgAn6Ds7aaJo3WwDP0lwjb7MUXVTPtZofMiNbNxpXLWGaTZmRlV104989+6sz+v
         ftcVwN84Z8lfY7X7BLIxyGw9SfysFrEBpNWo69ntfNSxcej0yCmBtaLwOY3Jq3e3etWJ
         7JPRHOQAdNBWJscQDaejOTodw7kXep2VIJBhkpZDHzs4LQA9MrAXkv7P0Tu579+2RaeX
         JfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760505413; x=1761110213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmdk0eUxok1/vVVsxuT3HWDsufBCi+dhI2wWj0KYVpc=;
        b=K4FbxZ4K7OHXYJs2aA3LJ6nuTehYy0b3CHj1rRqcDU/ZJ0KEEIDxE95ARcRduqKhWI
         S9DJIZbGTrWfqvXxotQ7oCyNfxwRY80H2dP0Py4fZyqosRsIlRVe6KInzFFQVFXIdi1D
         OutQ25X6SO/EbUuP9q4zYBK/yGJ0S9n68KQf5OxBh//XkwwUGZbQq7LQSeagC3wfwJnH
         BIlYsSIZuf5ah5S94dI3SUDH+9erhXFXFPrS5Y6Rj8qGyCD7oc/OS6FBnV2r0IOd32Fe
         NvtZQDv97ndIFc3Z658kQjRLG+Siz12AHtdLvSVn7eb9c1OEa1WBz8yYeqLlZTPiBX9/
         5+eA==
X-Forwarded-Encrypted: i=1; AJvYcCVXadN0w1Jgkd3z2TlH8vxhtUPGV6WOmAB9Jm87Epawuk2ttdh5RnKuXXVKurw6huknRp/GH0TvjUHvZzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmwN1hwgS7+nelsmYWDJ7h73XMJC4hiF8UDpvunmEspoaDjIf1
	QLOdDMyL1TQHTwGhQ+ln9viYwaFztI++ixwRTri+JmbayXGYfJ/mcH37
X-Gm-Gg: ASbGncvPqzG1ChgdNhYenUQTIre3YQUDfkezHTa9eE9l7AaTTqS9PWdnMTIyfahv1j9
	ijX8THzwZw1A8Y7VeDjcm7MzgKkiOOjOQDfmgfISliz0zxk22N7pMstps3bAEbi1Xhqt8HhQoeG
	YCuEnpelSEJW94qjkh4Alpblj0DfQALtMeD1gYC4hmZ+8SwCTxTTJdLcsCVwoiKGH8JK6TAP9Fs
	L3Tt9wILqqqdzsoDteQG86uL7iqnChthmjgpG+jHdcII90buulu7FUP6vqe/WXe5+0IERGunLBZ
	auErhao9n/ZY53HP2MxtyRnHBb7rvdUyQgl/4Qo+ciEDCdOV7kIwazUgiyI3i6eHdejRdgud6TK
	zaM/8fx6DOknKCCdC9FQt4yEm+g7Qgl2vGz1gh4HGKqlTZBQnU5gUVo38Vz8mHGA=
X-Google-Smtp-Source: AGHT+IFOYftdOIIXBVMZXIT1YClBipwIdLEu1Hwjcj5w8oVhfvDSEoo4/1DrLLJoT2GyhMPacQVVtA==
X-Received: by 2002:a05:6a00:3ccb:b0:781:1b4c:75fb with SMTP id d2e1a72fcca58-79386e4f82fmr38130945b3a.18.1760505412380;
        Tue, 14 Oct 2025 22:16:52 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060a38sm17320137b3a.5.2025.10.14.22.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 22:16:51 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: tiwai@suse.de,
	gregkh@linuxfoundation.org
Cc: broonie@kernel.org,
	cryolitia@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	pierre-louis.bossart@linux.dev,
	quic_wcheng@quicinc.com,
	r772577952@gmail.com,
	syzkaller@googlegroups.com,
	tiwai@suse.com
Subject: [PATCH v2 0/1] ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card
Date: Wed, 15 Oct 2025 13:16:44 +0800
Message-Id: <20251015051645.519470-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <877bwy81wi.wl-tiwai@suse.de>
References: <877bwy81wi.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Takashi,

Thanks for your suggestions. I have updated the commit message.

Please let me know if any changes are needed.

Best regards,
Jiaming Zhang

Jiaming Zhang (1):
  ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card

 sound/usb/card.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.34.1


