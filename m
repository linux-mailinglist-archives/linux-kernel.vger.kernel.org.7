Return-Path: <linux-kernel+bounces-834845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E390FBA5A19
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCA0E4E0326
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4029E0EE;
	Sat, 27 Sep 2025 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="sKhmHb+h"
Received: from mail-108-mta125.mxroute.com (mail-108-mta125.mxroute.com [136.175.108.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC2C29D270
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758957659; cv=none; b=rXIEg+6zHk6J0BNgaRhsO4cr+l29ub8OHb1+TkFMjZfZgEASFtiaEcdMB222+0A/volhKI3Mbzur4gcVDVZiy/nqgij8EYYwJ0eDN17sTlIZoyebptIeE7798quHaU7F29ouIcYy7/GS16SUUEnp6lFvP4SzYtB8cUzgLIBmP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758957659; c=relaxed/simple;
	bh=xgYxOpaT/Iobs1BrJfegcD18K53mxzzZ1+TaiJteypg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWMT2wiEWPcf76jXamjFWQ3iHWk4g5UE9+acvCB+8+TsAhjJq2D2CCp8p/095DmGGOoECgGCQsp9PQ4X0d4FHTKtC8OCy6KnSgYI1DFyEgFSX7r+Osp50Vf2ejng8CSwmS9GfAxBU/JZlSivWMJWbBtgc1spd6zF1yuntWbx88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=sKhmHb+h; arc=none smtp.client-ip=136.175.108.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta125.mxroute.com (ZoneMTA) with ESMTPSA id 1998a0723ff000c244.005
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 27 Sep 2025 07:15:47 +0000
X-Zone-Loop: 8cf82d905a0ab8585355fce9b9f58885983bb85bae30
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=ifFTIe/bJAX4sMNv6aWG1MK5yvIqxjIeJ9DcYQN9/j0=; b=s
	KhmHb+hiGBbIozrrJ5ug8TR9V0EHC3kpqdRZ6Nb3ax5pYvVC6D6sZW2E79jOmlVs+ilJ4hOVtDqLq
	DpritBOt+m06vM2FPg1vICFVcQB7doSbZ87cv/CyCjuxiCZYLBDetZrx6UOyaiBAHedLaWhnx/UZX
	mb9lDcEbyFGnap6wDTdumpKztE5qYGu9tyA7nVWmmBgpM0eVR+UrxGzstxnPLfhhNHTw8gY7vJMOR
	15ZIsdnvnWwy6gXyiN73Sc7mm5i9i6ciuhLJ59EoCz0kvgMuyHG54BjmQnTjDcqdj+sncZEDLoDxe
	xLd1i79VUlBlCo5mkqKzqvzDybY/wReag==;
From: Bo Sun <bo@mboxify.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>
Subject: [PATCH 0/2] octeontx2: fix bitmap leaks in PF and VF
Date: Sat, 27 Sep 2025 15:15:03 +0800
Message-Id: <20250927071505.915905-1-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com

Two small patches that free the AF_XDP bitmap in the PF and VF
remove paths.  Both carry the same Fixes tag and should go to
stable.

Bo Sun (2):
  octeontx2-vf: fix bitmap leak
  octeontx2-pf: fix bitmap leak

 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 1 +
 2 files changed, 2 insertions(+)


