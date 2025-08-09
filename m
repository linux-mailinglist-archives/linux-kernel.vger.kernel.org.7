Return-Path: <linux-kernel+bounces-761053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1BBB1F3CA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D427B2A3D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD55F2343C7;
	Sat,  9 Aug 2025 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGNkT/ke"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4494717578
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754732532; cv=none; b=N2SSdUaOPBZXBNZ6tA93gyPYsGpVb2zJH2Q67l2Wv+/T9wOFNgXZOoNZRTKDd64wM0wU9YxmU65PDd+cT36qXw8iNYYMD29TJnTOQxsti+jvpZYwE+2sn43pFbj1ojRZNjXLNKI7E9hj/EAMzv2Q8T90JRg/EpFNQ1dYtIr9pYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754732532; c=relaxed/simple;
	bh=j2QY98jubglHJ68c7htJta/+72H+Xj9aboXDUUKj6eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crFKX2zp9fFfVKJOGGDLwPAkHAaComnwa7s/Sv/Jka097SmRhQXYyeYoCHdmQ84EGeK0TnNRMXYtAfUjhMfnvcmImT9znKffCwJCq1vDn/vo+oMwnxOU1ZpMxHunRK9KmEo0t8GzYBvj0s1CK2okiYJcjC14f3k4YlZG7xQEXeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGNkT/ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3885C4CEE7;
	Sat,  9 Aug 2025 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754732531;
	bh=j2QY98jubglHJ68c7htJta/+72H+Xj9aboXDUUKj6eI=;
	h=From:To:Cc:Subject:Date:From;
	b=cGNkT/keFW5ORvQflETHcKVj4qF+nVLLy0UXWrrD5qcnCRhahMuILLFKgzB8vNBik
	 MPChOPbTqQFEBLHHHVtYI89ilALJTCEPj4/AwVsoArdUtfL4JFUTdtLM56TAZwuMh9
	 LGAeaGyJ61Uw0DuGUxQPYnGEBLtzq+Hbx4bx24o/cwSrsIiJODiJ0dn4NO4+T6ma38
	 PN/Sh84QSoBL2yxNSshvsHXLc2FgUgcJt31Net0H0EszOtngX3wP886qxHLSoeOKLI
	 9ZcTtOi+mQPx7XQsEkxBTorHKiZ07vx6/xgo8ixMZHphkMMMTp+v+fRSYH7Mth56lX
	 CZUjg0cGO4FjA==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 0/2] x86/microcode: Add debugging glue
Date: Sat,  9 Aug 2025 11:42:04 +0200
Message-ID: <20250809094206.28028-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi,

this is something I've been meaning to do for a long time: each time when
doing despicable things to the loader, I get to add debugging code too and run
it in a VM to see how those despicable things fare. But then I remove the
debugging glue again when cleaning up the despicable things and turning them
into proper patches.

So make this debugging code permanent but keep it out of reach from production
use and have it build- and boot-disabled  by default.

Thx.

Borislav Petkov (AMD) (2):
  x86/microcode: Add microcode= cmdline parsing
  x86/microcode: Add microcode loader debugging functionality

 .../admin-guide/kernel-parameters.txt         | 15 +++-
 arch/x86/Kconfig                              | 12 +++
 arch/x86/kernel/cpu/microcode/amd.c           | 88 ++++++++++++++-----
 arch/x86/kernel/cpu/microcode/core.c          | 55 ++++++++++--
 arch/x86/kernel/cpu/microcode/internal.h      | 10 +++
 5 files changed, 149 insertions(+), 31 deletions(-)

-- 
2.43.0


