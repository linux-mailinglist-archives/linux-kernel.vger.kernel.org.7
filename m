Return-Path: <linux-kernel+bounces-726199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6EDB00961
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8393A3B7AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F19C2EFDB6;
	Thu, 10 Jul 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIXHIK87"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D9148832;
	Thu, 10 Jul 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166685; cv=none; b=IkyjK9X+7RcI8zDmtoT03xow92xUtf6M9s9XFU+2SEg5FJ8nJ65bbam63AWU6IyLTsXLlhhZcUxMwQdBSfj8qxQAU8AnNxXk00Gqwgs6uly0Wz/pKiUWGl13HKPfLE9NeSOD1maeztPVAS1m67V1mx7t8FDVyg2Z5zDkBvYJlbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166685; c=relaxed/simple;
	bh=1RMo+DfcstuQhdENa0J0RvyHD1/SNOxqFNawl5TgHD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hA2B9tR+s0BDpOUJkLvlQIM0fIMitaY/9cd25QlJNMTkTiiDg46Ihoxi83IjmuPnyNUWG88MBbPWpGXCQkMx27yHw68/TOlLCnJzWr/H2ViRP3cct3zM+RbHsiGKJ+y7fEAG0yxqtwQ0OTp+UEvGyRMxC/4PF164wep6duVQqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIXHIK87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814E5C4CEF4;
	Thu, 10 Jul 2025 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752166685;
	bh=1RMo+DfcstuQhdENa0J0RvyHD1/SNOxqFNawl5TgHD4=;
	h=Date:From:To:Cc:Subject:From;
	b=PIXHIK87CK5n0hHlp4hieAHBQwgyEMsPFIWmYsAMmbNN3RTdyzJyz7ASbUNwMe/NH
	 vVqYHrdaAm+5SLN9xJcun7bVnuoDChvmWVr3z7zJdOe0Q5OYEVFEcKhEJN7jnyqcwJ
	 VxYXPKNCRg/6vu2IiGX+Qx48HCZeK51pZo5pVAiM4jUDAC8rE+nW4MMLQKbLM54Si0
	 mWL17IinWFYj/SBt6xvPRRVa2cMWKSBnIYvOrQ5GD/uqi++trzV3wEN83TzIc9LZyB
	 KoYzsmiuIgMaCAEPLeW5941J20KXWlL5jKZZyK2u241VWPZXPsbqtDwvbBeDO88zwg
	 fjuZue6AopTDQ==
Date: Thu, 10 Jul 2025 09:58:01 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 20.1.8 uploaded
Message-ID: <20250710165801.GA4073042@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 20.1.8 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

This is expected to be the last 20.x release. As always, if there are
any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we can
ensure they are fixed in main before the 21.x branch cut on Tuesday.

Cheers,
Nathan

