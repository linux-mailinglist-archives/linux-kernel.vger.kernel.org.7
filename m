Return-Path: <linux-kernel+bounces-829899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E21BB98259
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 019027A9EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC03225785;
	Wed, 24 Sep 2025 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFwHtygR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2FF54774;
	Wed, 24 Sep 2025 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758684968; cv=none; b=IqDSxk5GOoCj87vcs6JDgStnXtsjOXw/cWPE6pxuTGzgd7UJTtXN5siuS/XCCxf6BwWbnDjc3co1VGhfYAauCAtA5lkn4cY+WIun09gOjV93vDO9QIr9MWY+W6KA8OldK2lKyZ/+WqnFQuCUI/U5OWj3HzE1claywfFK0iUY+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758684968; c=relaxed/simple;
	bh=7Z9Jed+9q9f+fkkuhQDz+OYZPAArlN9eI39UwatcfQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BpfU/1O+MOeW40Ri3AE5NJLUqZ2QuX45p4Iz9mzX2w73qZrE9Yvod8hd3Aa+oVa/QlGVz1gMoACJ/JBsTkw9aAtlSj7EJ/3GXO3bOft5YNc9GSJxsFbVv+t78IBTkdne2lPoIzzanwIe/acTGCneGibo+7N5nqhUmRXa0CyMHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFwHtygR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB5BC4CEE7;
	Wed, 24 Sep 2025 03:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758684967;
	bh=7Z9Jed+9q9f+fkkuhQDz+OYZPAArlN9eI39UwatcfQc=;
	h=Date:From:To:Cc:Subject:From;
	b=HFwHtygR40mrAuTzmD1cDNowxFhKxcc85JR+Tls3lzlfZo7OmeQZrB00y46R3LOna
	 rLcfFFryj3xmynYjG8dOcuPAaiSK1n3GIsK2bkeIzHVsZ4QGYW7SjD08gXyK96HdeY
	 wpY+gRDwbuPJdjm7SO79Yck8y2t7nlflKGcN/zbsn7jRrinuB6juakbX8zq+XHWZjl
	 jg/4mzZNbNUFwIlSWPrdwwUh5j9AnUffTLOT8Ep1MLZIWI/1B6PO5F+QZZve3zcTfk
	 cHr430J/3mT7DkRAZ7NuSs6oBKNdSodLAnNH2lXjwpKmOJCy4eunZO2Opbme1xe4O5
	 BNqqMngSpu/lw==
Date: Tue, 23 Sep 2025 20:36:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 21.1.2 uploaded
Message-ID: <20250924033603.GA1736082@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 21.1.2 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 21.x
series is no longer supported.

Cheers,
Nathan

