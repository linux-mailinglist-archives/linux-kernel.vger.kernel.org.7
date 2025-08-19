Return-Path: <linux-kernel+bounces-775751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F82B2C46F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D12717716A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFDDF513;
	Tue, 19 Aug 2025 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACr4UIY1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE633A012
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608321; cv=none; b=QlZRGTqrk7Q4Vp0I0k/yEcneFVZn4DAyK46pa6Y9YLqk2+3aRaF2F21VKaagRIZ8OLJ5QOQ4+N/7lxwUBiNqBM5g92+IVc5qbbWuM6RN8JWNoN6OwXO15XgqqrEdrTYUJxLiLMJeHAfThp9VUD6/5CHLHsj7X2RxnosyRjqws70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608321; c=relaxed/simple;
	bh=n2t5emQ9nQKomcl/kmkdWW6rIzDhhXJ1oMADtjmO8NE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rw33kIvhE/dxb255lIkUHuDuafdNjb+FqXg+4kVhqRoxZKD7K2MSSUKFh4yBuhgv3aaJBgfH+TQe/pZpj5kej22xZajobKr3wYtCXZfNVR+ULGxRgKlxVymhTQYKgH5HVNA6qzN9DMYhNDcGL3DQ7biH1N89iOuwqgvsU3UBHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACr4UIY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E14EC4CEF1;
	Tue, 19 Aug 2025 12:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755608320;
	bh=n2t5emQ9nQKomcl/kmkdWW6rIzDhhXJ1oMADtjmO8NE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ACr4UIY1JjYJXn8MjHQiZPCQ5OFXjhky9Ejevd1h9W+s3THIkKdJvsJvS++BJySUv
	 l3GN/8UhqfA9rB5fASFhoa80/zkoyqhXVxz1114whsvyRQhRhIpsqbSsdZ5hUUmSqL
	 6dhE1W5CnfwqDQHto7Qc0gxqkJur5aSYNnComCNUjc0grSQ7bZvLhOaDYt+XecWt2o
	 cnqxAF0/dL+KFfrK5ll9Mik6KSSDc7nnH+vkv52Fzu2wuEEovGidvcuDNYdvXyq+9g
	 KHANSNyVGgF2/JF+AB59lFx/rw2n7S/F9xKOy2iyHX6QmPE8F2zP6wYGj6M8SIyUI6
	 3aYqD/jCQOtdQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, andriy.shevchenko@linux.intel.com, 
 linux-kernel@vger.kernel.org, 
 "Heijligen, Thomas" <thomas.heijligen@secunet.com>
Cc: "Huber, Nico" <Nico.Huber@secunet.com>, michael.brunner@kontron.com, 
 "Schumann, Peter" <Peter.Schumann@secunet.com>
In-Reply-To: <7d2c7e92253d851194a781720051536cca2722b8.camel@secunet.com>
References: <7d2c7e92253d851194a781720051536cca2722b8.camel@secunet.com>
Subject: Re: (subset) [PATCH v2] mfd: kempld: Switch back to earlier
 ->init() behavior
Message-Id: <175560831907.965378.15824431424969459890.b4-ty@kernel.org>
Date: Tue, 19 Aug 2025 13:58:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Thu, 31 Jul 2025 14:45:00 +0000, Heijligen, Thomas wrote:
> Commit 9e36775c22c7 ("mfd: kempld: Remove custom DMI matching code")
> removes the ability to load the driver if no matching system DMI data
> is found. Before this commit the driver could be loaded using
> alternative methods such as ACPI or `force_device_id` in the absence
> of a matching system DMI entry.
> 
> Restore this ability while keeping the refactored
> `platform_device_info` table.
> 
> [...]

Applied, thanks!

[1/1] mfd: kempld: Switch back to earlier ->init() behavior
      commit: 5256abb7faba92e3c49dbd6aabd42f17ddf218ea

--
Lee Jones [李琼斯]


