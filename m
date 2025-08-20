Return-Path: <linux-kernel+bounces-776755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F3FB2D12E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1127BAD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC419F48D;
	Wed, 20 Aug 2025 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="raWsjQsN"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE32286A1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652023; cv=none; b=G3eZPDJVcFhYCN1sKpRL9StKBHYd8L8tg1NKXi2zWrSxtiSK4sy0t7kzflBtetjvmmBM4PsEIXb64/ZV4BKCT0wdrZkZh27F2O2/j62rDzHGLK2g8lpN4ZvteLKM9SFvb5Ceii4dDUGoO5/dLUFqBG/wEqJ4nQTnqRxvSmVgDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652023; c=relaxed/simple;
	bh=8dCUsBKgFZu9Sx/mUQsUP8cJCuew4ZAV1wCt1Is5R0U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=P4RAaMtjhsuX6A5+a2B2gso72stTmGibrBcJwSOQPw3d0gXkpTgk7iMGdj+Qqm/8AkBgLeXvVJqAJSfWz0S+z2WHwgrwEQq0jVp+kqdiEaEzIWh80sGjSvJI185DwpDcIgq0fUKcN3vZdFZur4JX4ucSv1sz6vPPCcEnh+wUKzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=raWsjQsN; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755651697; bh=8dCUsBKgFZu9Sx/mUQsUP8cJCuew4ZAV1wCt1Is5R0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=raWsjQsNk+a3swPtJ3OC4Mc9C4UejMOKAPPXlshDdILIYx9657tOX4mMxyAiZrc+s
	 h9Ov8Nxv6RIp3Z18OUwr+47BbEAUkAa7ATjBqCnvGN9MrYwuxQAHQlus8PszF4Y1jx
	 azNGRJljS++oXbf5E0thg36QeobUI1H9mNd7UtCU=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 621CC3F; Wed, 20 Aug 2025 09:01:34 +0800
X-QQ-mid: xmsmtpt1755651694trs4p78zh
Message-ID: <tencent_D46EBC9510E942ED0ECC4078F66E802C390A@qq.com>
X-QQ-XMAILINFO: Nq4zXdVTSZRGu0tTCEDdrMVnQ107P9Z/nC475fWmT4/fQqjDLV5kRPAPykk7Ti
	 0JnXIc7zd1sHo7YmQSTix+7wb9PVLSCWXtLPJLuhcF/IK3XJps6Hsz2gRIAMpGjCj9HmcGG0/6hB
	 5mjEGb6k41Sm/a3CGYJvlc+rmpwwKajceLfi+3nFfUgyWiH/lfjhLb14OVwBPrWVq5YJs7Nu5xb8
	 pOLZNra3gzz19ycq2rS6cmPYikZqaPaq80uDAvAgVT55Wa12/G65ZB0v05HoxGxAfikhJ4oPm2Wi
	 JF4b00eAptbHbC3EWVuaYos+94OS5uRe0rDia9nRRpCaX7mRfCPnsba5HPGlaEsPFeEYySBwb0Uj
	 ylzU7A39Br6ZuUoc8v1nQ4kV+TtZUoTp6M+Q8OImlQQteQGuRWbUv+tmpRtxkHcYwf5ORmm2HIhu
	 LppGKe2yw0DJBhm/GfTWrnmnAMaDbLVQT+amrqiorgwr7HerhZsUCReROHsZQYkeWT1/X2hitbG3
	 8ATqBvUOc/6hiS05uBKkaQ8v2lcKpulBxfMMBzeq+3getq/1T4pPy39CKeQtkjQcZtFLj/mihQjX
	 GCYFVbgTsZ9cALls9rx1y5k7Wuk9i7HFfVKrUfd9zuG3R6oUq4FwGgC6elyUQRC1PoLlwzFUcPDT
	 G9KKBcFOiRStsex3LJcHky7N7QBS4IzMEMM7NUU6G33chnOMm/KOBC6aEF/d892k7PAEkHx4sw9G
	 HSaSbxqL9YRkCDqsMLwP4JLyuq3CH8/1Baxot5KtPJvFfEfoxOCraey8yNe56QJyHYeZgY/zBA5L
	 M41TQdm92L6eXWS6tH1f/q45e5RxY8ieWoPBvwpZ5QbfSD+WwlHc1WS83aX2rt5XdFmYPmjGg5cM
	 BbBlWpIs2+2xKTEVj17cwgo4WqZcyTnr+aZKgP1sjHD6yjFfIhCf91uA/o5u2DWJpCv4IWN7w58e
	 IobhIoZH79W86pT3jHKFn2FaW8ymdJ
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: mark.tinguely@oracle.com
Cc: eadavis@qq.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [External] : [PATCH V2] ocfs2: prevent release journal inode after journal shutdown
Date: Wed, 20 Aug 2025 09:01:34 +0800
X-OQ-MSGID: <20250820010133.1334456-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <a365b3cd-b1b5-4d04-9877-129286345ce0@oracle.com>
References: <a365b3cd-b1b5-4d04-9877-129286345ce0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Aug 2025 09:17:40 -0500, Mark Tinguely wrote:
> fixes commit da5e7c87827e8caa6a1eeec6d95dcf74ab592a01
> (v5.15-5-gda5e7c87827). Also for the stable branch?
I think the patch is suitable for all stable branches containing
da5e7c87827e8caa6a1eeec6d95dcf74ab592a01.

BR,
Edward


