Return-Path: <linux-kernel+bounces-899364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A0DC57845
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C2D421401
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF55350283;
	Thu, 13 Nov 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pDFSpkhG"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98612FE58F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038459; cv=none; b=pB8OvYCCjmQYN5ZZ5AyZBj9CbMCl/gFN7UC1NKtKQhtqWO7w+cfsVOz+5zSBiv1iiNWtxPNotA6lxoZ+JRAuTlixS4/6gVzL7REFT04ZU8TdMqLNmNFnFNYaYp1lZHugD9JHQMeSjmYAUF1GDa8EyZZbpu9BVeFvUhiFX23ZMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038459; c=relaxed/simple;
	bh=sOv3gpVFSUTOf8qccBUFlmorrQlW6YAkct0+Z3bQd3Y=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=rHXjC6kCWDpVbfRDb05+EmwcdWuOhAjBzIPaR13U1wdLw2JnKyFrFzZxz+Zq2uM/XMEp1YsZcqfVrZ0Jo5Vc6C6+KnXkb7THEPrYSqAJaOdvSA6LxHXJOFkbqrzeu4gOZV2V8XCd0qjsfUdUjSfjaXKFzDV5znYd7GIn/uo/yHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pDFSpkhG; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1763038447; bh=/GQTtJfCoEQKgTxPit1J56QLlgdP/pwagyLI+EW9z0I=;
	h=From:To:Cc:Subject:Date;
	b=pDFSpkhGrwU56CzdRuc/UKskuLMIb9VM04e5wU5yZYVDo7wHpNkvV2yZ3JZosEIR8
	 fzrpv2xThIcaJgh86QMMCv6tRjvbOAJg1G1jTpNkVnKad/ytdv2Fcw4BrXl3UzSots
	 9ZDcb0WN0xQFTkiihibdg9+SZDtggye4LWjFpnFU=
Received: from cjz-VMware-Virtual-Platform ([110.176.66.153])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id D393A6E6; Thu, 13 Nov 2025 20:52:57 +0800
X-QQ-mid: xmsmtpt1763038377towqfyh7c
Message-ID: <tencent_67481983755837947ADD1DAD8BB36FEF880A@qq.com>
X-QQ-XMAILINFO: MvUAcPkRmFBfRVa3KPbA1xUSqTPMJ44CrUz1iwiZsKDSpzjyo2Sr6sDvcPYZJm
	 3BCS7uVdl9iraSveiOzE24J4FEXP6h9eKDUWhHCK8JQWzJq5K9umCDt53NxJm3+CGnRUB5UA7CDt
	 OrCakPxHrv+iMXSznNA668OUpiBXzV54l97536ivDu803QZ2NpUi1KFu0FhMeAhowc+l71fONuzD
	 7MvPhZXcmakgsjq1HPg8mNiGpCn/d0ImziZlXh9v2/Np07jcRlCr42aNvw1YU5QlGvg/lmOsRaDn
	 kRpcbAvu7n+MQUrVaNQCtgYltagMKOqaN9dFhWJcjYv8l5JRTi4tDVsMAYF/LzcVdBm3yL5LoR9m
	 MNkeqlD5cKIZtJ+1XaujN0car7jyFZNAAYapo0k4wkwErrN6DBrH+zxjrPuvmh3nj5QRTrrEkzX0
	 oTvPXHrQ24XUkIij/zdPORFYYON/BpkSYO5tqBO+FRPPwTcy2B9fYlUGQBRxwt/jmQm4LfcnMrci
	 z4yeD7IwQ0PbsuOQbJsHBhmWcRUXt9ilH1Q9S9mkXegDt4vwB6TpBsDRUxE2dFInUmgUtNYQha+3
	 wpOqKpfoaejUEe0OhAjDTbrgaKwMKpouz7Oe+hQV++FsN/xV5wh53fAsG+qjAxIZPXrMEuZNJ304
	 rjQDPGtvZEpOopV08vIf2dcTxR1q6TCrxHB00FGz6bxXnWqaafpVD9Ra8gIlpPrQZwpsTJNowgs4
	 /ZVxLLuo9uDAjwlLfPvjuP2Giz6xQvYbl/ClNWqTsFnaZ8UVIWWs2viwrAjBiaaC7nSwx6/90LWB
	 E3DpoII47GmesnuhG2JuWc8tyKznCRbn9gaAwu2fzYsIooLoHlo+P9H19z0nkOKcjvRiaeH5bDDr
	 rpyFavu58U6mlSYcaM11VH0tYJ4h0FbLSRLl7/+lQGD3VAHPu7sh70iOU6av8bfLSTN51iLJeFRr
	 Wr8ccLMZkxGRW7lifrAoCz6zHdn46nfKllWRlr5URMLSoRn+GGq2amUZZfWOfb51mcULlx42+GA2
	 6V4xZbvgxp48AzW7Bs
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Chang Junzheng <guagua210311@qq.com>
To: outreachy@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	guagua210311@qq.com,
	Chang Junzheng <guagua210311@outlook.com>
Subject: [PATCH] staging: greybus: audio_manager_module: make envp array static const
Date: Thu, 13 Nov 2025 20:52:52 +0800
X-OQ-MSGID: <20251113125253.72693-1-guagua210311@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chang Junzheng <guagua210311@outlook.com>

The envp array in send_add_uevent() function is declared as a non-const
local array, which triggers the following checkpatch.pl warning:

WARNING: char * array declaration might be better as static const

Change the declaration to 'static const char * const' to improve code
safety by making the array read-only and allow for better compiler
optimization. This follows the kernel coding style recommendations.

Signed-off-by: Chang Junzheng <guagua210311@qq.com>
---
 drivers/staging/greybus/audio_manager_module.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
index 4a4dfb42f50f..ca6a2cd0bc4f 100644
--- a/drivers/staging/greybus/audio_manager_module.c
+++ b/drivers/staging/greybus/audio_manager_module.c
@@ -159,14 +159,14 @@ static void send_add_uevent(struct gb_audio_manager_module *module)
 	char ip_devices_string[64];
 	char op_devices_string[64];
 
-	char *envp[] = {
-		name_string,
-		vid_string,
-		pid_string,
-		intf_id_string,
-		ip_devices_string,
-		op_devices_string,
-		NULL
+	static const char * const envp[] = {
+						name_string,
+						vid_string,
+						pid_string,
+						intf_id_string,
+						ip_devices_string,
+						op_devices_string,
+						NULL
 	};
 
 	snprintf(name_string, 128, "NAME=%s", module->desc.name);
-- 
2.43.0


