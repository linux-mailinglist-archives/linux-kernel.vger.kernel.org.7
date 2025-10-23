Return-Path: <linux-kernel+bounces-867734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C42AC0364A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903C01A05DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54B238C0A;
	Thu, 23 Oct 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2eAcJZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360F17C21C;
	Thu, 23 Oct 2025 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761251494; cv=none; b=PC+berozs2YB7UTv3wP+h9lv+I4le8e+y7kv0j60lD3Dj33khpCRKLB0H/TkruOVNNXNGTlGSdpK3J2GqvGb0NpDBBXkyG3yAIHpmSbtvJ2MitAjJsRK2cHbCEVAY2KZNMLOcmKs51vPXms7w83MYR+ewue4HCDij2VK0rVqn50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761251494; c=relaxed/simple;
	bh=rOyXGCg7UmEtNTCZZuBA9r74JK6zGQ/KTZPLM6OVdSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUbKZK/tE3NUbEQkd66F53ytqLxnxDQl1OAR2xHjDUHScYgBSBZoDW9G/UZ6SUU2hZtq1KeraxwS0EOP21nab/kJHTdW/sNPdQplZ44XT2z0uwGiLiVmFUGWjS9TPjCKZ3kIWb3sn7jL27X041HC8KK0rudeKNeSIvdP9O4gyg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2eAcJZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D861C4CEE7;
	Thu, 23 Oct 2025 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761251494;
	bh=rOyXGCg7UmEtNTCZZuBA9r74JK6zGQ/KTZPLM6OVdSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2eAcJZirgUzEEqTJ29znDpDb4AeGkkhWIPfg5rEX4S32msTTVevJUiDTgLrq2WGn
	 JmrpX0itb6ExW9r9Bz9kTneV9ydqxNRFqMESHaCAb12bJ2ocWVNoG6yIZfm1QjChKi
	 Ki1HUfZIYb7Myjg+cNaROTUk9N8GQpO4ow8yqI+XJ3U2pkH6vZ1qd6e12d2/rRQFww
	 loJCXSqX7LFV8AKysOxCAYMessZud1ZoHvwe4TYgglL6blTUpej/dFmOkD0V3oGLFl
	 In+tHu25GR5GRC5wcgiQoJoRHmU46UoIOgCL/g+ODqvr2QaXMIzy9RlZk6XfjcqdjG
	 zWVRRZYx24Saw==
From: Nicolas Schier <nsc@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH] jfs: Rename _inline to avoid conflict with clang's '-fms-extensions'
Date: Thu, 23 Oct 2025 22:31:18 +0200
Message-ID: <176125134618.2701009.7020323237839096671.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023-jfs-fix-conflict-with-clang-ms-ext-v1-1-e219d59a1e68@kernel.org>
References: <20251023-jfs-fix-conflict-with-clang-ms-ext-v1-1-e219d59a1e68@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 Oct 2025 10:38:50 -0700, Nathan Chancellor wrote:
> After commit 778740ee2d00 ("Kbuild: enable -fms-extensions"), building
> fs/jfs fails with clang:
> 
>   In file included from fs/jfs/jfs_unicode.c:8:
>   fs/jfs/jfs_incore.h:86:13: error: type name does not allow function specifier to be specified
>      86 |                                         unchar _inline[128];
>         |                                                ^
>   fs/jfs/jfs_incore.h:86:20: error: expected member name or ';' after declaration specifiers
>      86 |                                         unchar _inline[128];
>         |                                         ~~~~~~~~~~~~~~^
> 
> [...]

Applie to kbuild-next, thanks!

[1/1] jfs: Rename _inline to avoid conflict with clang's '-fms-extensions'
      commit: 9b38933a351d4f4e95a192adfe21ec235632bf4c

Please note that commit hashes might change in case of issues with
kbuild-next branch.

Best regards,
-- 
Nicolas


