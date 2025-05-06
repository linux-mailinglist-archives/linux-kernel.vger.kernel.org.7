Return-Path: <linux-kernel+bounces-636735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0E9AACF62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 23:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681A51BA5BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EBF21639B;
	Tue,  6 May 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od34i7o9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65170A32;
	Tue,  6 May 2025 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746566047; cv=none; b=MgoGmjddfCu0Wnq5XrkJ2hl3pf1RMKo+qpOfzLa/s2BjcLBqPeoSOfGCMSua1nSu6LVqsLQC+tpjuAw0SXuJDHj9lfGGeny2+Tkdn/U1asuz/AkmjoH/WxPblhc40faQ96b8xH0GIcslqd05KRArh3fHyLJclatEYrBoyK9H/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746566047; c=relaxed/simple;
	bh=a76spNwHqt4oaRtq0+HT1IMg+SPd9AC58bwiWAm/D5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O4F9k/LI2LrXk56uu39tENUGvldnwi+pOOMNMswc+/snvxPUjK0rtKi/vYxbXo7veq5eifFDNirMUD/fhZ2iHtkm/jTvm0Oyb6aB4f1fuvTpv+x65t+HQIiIcU14bd+LTC2C+wkoHnSU4WcQhaeGyfKIUg+RU0yRRlZlI7l72o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od34i7o9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82598C4CEE4;
	Tue,  6 May 2025 21:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746566045;
	bh=a76spNwHqt4oaRtq0+HT1IMg+SPd9AC58bwiWAm/D5E=;
	h=Date:From:To:Cc:Subject:From;
	b=od34i7o9rz5LtxsYSVnMTBVjyTE4j6QwzJxetiUBOSKR5pW8JyjvTspVXC2lIcFXz
	 EXGAftVux93BVzWXC4kkJhPD7uaTsYqkZFLEXlakdXv99Fyi1cOMyCw9Z0R7pSOEn5
	 jYYm0lowUWDmfnNNf4UdkSqF20RllsKUcq/NJuFB3BbNr+XoImS+ThMGsAJGfkLlYP
	 HCFV/q22laLUuYBOJXpSLpAzENxJQIObTVqD9oWyw6W+kh1dsn2Fmbqc8+fJClkqna
	 +C98XOAlOotxMaJ9XleFNwk65FhO9T4AgkyALA26VuH6rm6vv8Y+XUyVjMFW7P1R48
	 r+goKOZAKW40A==
Date: Tue, 6 May 2025 15:14:01 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] platform/chrome: Avoid -Wflex-array-member-not-at-end
Message-ID: <aBp7mZ8kj9w4CKkl@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct cros_ec_command` is a flexible structure --a structure
that contains a flexible-array member.

Fix the following warning:

drivers/platform/chrome/cros_ec_proto_test_util.h:16:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto_test_util.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto_test_util.h b/drivers/platform/chrome/cros_ec_proto_test_util.h
index 414002271c9c..b17239f052c2 100644
--- a/drivers/platform/chrome/cros_ec_proto_test_util.h
+++ b/drivers/platform/chrome/cros_ec_proto_test_util.h
@@ -13,7 +13,6 @@ struct ec_xfer_mock {
 	struct kunit *test;
 
 	/* input */
-	struct cros_ec_command msg;
 	void *i_data;
 
 	/* output */
@@ -21,6 +20,10 @@ struct ec_xfer_mock {
 	int result;
 	void *o_data;
 	u32 o_data_len;
+
+	/* input */
+	/* Must be last -ends in a flexible-array member. */
+	struct cros_ec_command msg;
 };
 
 extern int cros_kunit_ec_xfer_mock_default_result;
-- 
2.43.0


