Return-Path: <linux-kernel+bounces-853060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AF6BDA8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52343546465
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1FD30146C;
	Tue, 14 Oct 2025 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeDeYIiH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92512CD88;
	Tue, 14 Oct 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458042; cv=none; b=rMmoCmBioKaGgNEhUpm9HtC0AOjtoc1AJYorOwL0toKOjXjiNh1v1vY3wCbX6UIBN8OC53AjJeiteoKpVLwBSAvf3gWiaKAq0AWAoTVkTayXDmdHuO6rscIq35Gx5q8J6GZJWFUn1dOtZEY+mtwmMHDempdqv6NX3rjO2Keh8CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458042; c=relaxed/simple;
	bh=oGioMHVrYPjHthz7IOPAwGPjgyiAkYI633zr9YW6Tnk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RygGj27nSN0qLox469sO2NmHPDN+PKt8DvqP9eicUx9XLzf36+UPVU/ZPQIoZsLA4vQiYN3S2jhIDsi6CFCVdFzrTNSXw0UYyDlzWYJzerd9SMjL5HtJ3BVeN9LJmqiKS2tJskloYgtCSP5Q0jdmATYOTt5YahQ0lbiGJQHqlIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeDeYIiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A00C4CEF9;
	Tue, 14 Oct 2025 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760458041;
	bh=oGioMHVrYPjHthz7IOPAwGPjgyiAkYI633zr9YW6Tnk=;
	h=From:Subject:Date:To:Cc:From;
	b=KeDeYIiHLdAf36xlSHgGY9JJagx9XZCYzM7zfxse2XsjE/NjMvRJUN+lTZeghr7VJ
	 Wqzr4aM+jU3KsjSh6YCvUkSHwqYExuLjjGKFhIs0I2Y9UIKNNZUUFXYpw+L7DHQK+n
	 nyTZx5cfW0eX6nxBKZw0QaeYO74ld2y+/nVLqN9AwqJpCRE0zjbgIRR8MAVFQ3O9OW
	 X0OkPQv60Zrwb+Ab4e2fHayHLXDpBrZKopchgzEAd4uCQkbnMEqQyYOifYul4rUvdf
	 akvfjGrt3DoAwpwSmyRO5wdV/ErZfsKwFPYO4cha6/YQCZl6FdmPyUeFuBlzluWJH3
	 +Z7tRQ3Y393hA==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/3] TBT3/USB4 support for PS8830
Date: Tue, 14 Oct 2025 18:06:44 +0200
Message-Id: <20251014-topic-ps883x_usb4-v1-0-e6adb1a4296e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABV17mgC/x3MTQqAIBBA4avErBP8K6KrRITpVLMpcSqE6O5Jy
 2/x3gOMiZChrx5IeBPTsReougK/uX1FQaEYtNSNkrIV5xHJi8hdZ/J08WyF0cF642bnvILSxYQ
 L5f85jO/7AaDJagVjAAAA
X-Change-ID: 20251006-topic-ps883x_usb4-32d4c3abaac1
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, 
 Jack Pham <jack.pham@oss.qualcomm.com>, 
 Raghavendra Thoorpu <rthoorpu@qti.qualcomm.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760458037; l=993;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=oGioMHVrYPjHthz7IOPAwGPjgyiAkYI633zr9YW6Tnk=;
 b=Z5mQj97v7KHFNVHEuSiRV9H2V+7lI4+9oDiItCkEU86p3pnCxxxyJFo9uakYYoZtym6le+2Jr
 ZoEDH8kr1HoAKugR6t+jQBNNQDmCFJtM0S5TBt4ilNIbwnvGRAPVWHF
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

As the product page [1] states, the chip is actually capable of
retiming USB4 and Thunderbolt 3 (4, even!) signals, while remaining
spec-compliant.

This series reworks the driver a little and introduces support for the
new aforementioned modes.

I carried Jack's Reviewed-by tags from an internal preview submission,
which I hope is fine with everyone.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (3):
      usb: typec: ps883x: Cache register settings, not Type-C mode
      usb: typec: ps883x: Rework ps883x_set()
      usb: typec: ps883x: Add USB4 mode and TBT3 altmode support

 drivers/usb/typec/mux/ps883x.c | 129 ++++++++++++++++++++++++++---------------
 include/linux/usb/typec_tbt.h  |   1 +
 2 files changed, 83 insertions(+), 47 deletions(-)
---
base-commit: 52ba76324a9d7c39830c850999210a36ef023cde
change-id: 20251006-topic-ps883x_usb4-32d4c3abaac1

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


