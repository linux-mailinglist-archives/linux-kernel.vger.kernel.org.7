Return-Path: <linux-kernel+bounces-814080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D400FB54EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F29A7C7BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91630DD35;
	Fri, 12 Sep 2025 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2I0j5yX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA330DD0B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682794; cv=none; b=jLXFQ0DIOxwqohYQVCBLpzKjdf0ATqzUt+vEYj+semgACccSh+Zlsw0cGl7YaAiaQ0iwcgARsH6jENOiUOKs3v8U2rHRmjsw6hDd5cbdQlevH6owh+vz2/kpQbyLR18/OI6GmhWDKxJo9MTdGPT2DTqeRRTQUHV4beN3sCqwN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682794; c=relaxed/simple;
	bh=I3uc5v38YjLrIBNmiNuvx9FTcSXpMa14aoGNM815qDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZGfGVNaIp118NVIm8JhwvNmBbAlGK4cpfzpJNkMK1CASS2weGbCz6ErBdCNXS+p8VD4jxhnNdawoFaPVx3yrp3hAgl4LcgIL8SbFBatAuaG4Tms9HfeSg5rIA68+SFZoMQSDg7tegdzj4eEubyQVq/cauKVH9G3rTnAJKLz9vfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2I0j5yX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8B1C4CEF1;
	Fri, 12 Sep 2025 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682793;
	bh=I3uc5v38YjLrIBNmiNuvx9FTcSXpMa14aoGNM815qDw=;
	h=From:To:Cc:Subject:Date:From;
	b=N2I0j5yXcNp+RZ7c0pEL51diDMSv3CeUpDsBlzEmeUOo5/ZOuCmRcUyaA26WlbU0S
	 UNIlVBx3D3G7IKZ3hEGgF+xaZoWQhrw9X774q1JgAr7mrHdoTCXdVqCXNtNAmpn0HO
	 XxyW7E48pfdkRgq11+10GsrXLcNjwj27hMMtVYvzJhxaUU/paIKwx8xfnO3dOSnRB1
	 cdtnKzQrvQeygtqYTSSTCIZ4YQzRJoWDCvcAk4wCkNczZab6G8okLb6km/x7roMdDJ
	 0MWzrc/mAlEqeKB2ff444Yg1nThDSKLIVbb8k/DpWk/m900YVuBj1ozMTc3aaHSRcc
	 IhCd3xuc5cu0Q==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 0/4] fastrpc: patches for 6.18
Date: Fri, 12 Sep 2025 14:12:58 +0100
Message-ID: <20250912131302.303199-1-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srini@kernel.org>

Hi Greg,

Here are few fastrpc patches for 6.18, Could you please queue
these for 6.18.

Patches mainly include cleaning up how the domain id and names are
used and make this more sustainable, and easy to add new domains.

Thanks,
Srini

Ling Xu (4):
  dt-bindings: misc: qcom,fastrpc: Add GDSP label
  misc: fastrpc: Remove kernel-side domain checks from capability ioctl
  misc: fastrpc: Cleanup the domain names
  misc: fastrpc: add support for gdsp remoteproc

 .../bindings/misc/qcom,fastrpc.yaml           |  2 +
 drivers/misc/fastrpc.c                        | 54 +++++++++----------
 include/uapi/misc/fastrpc.h                   |  2 +-
 3 files changed, 28 insertions(+), 30 deletions(-)

-- 
2.50.0


