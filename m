Return-Path: <linux-kernel+bounces-804311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD31B471C5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0C4A01CE6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B746E21018A;
	Sat,  6 Sep 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="DgQxAKLf"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9F1C860B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757171655; cv=none; b=GCLNYZoIQ6GiPj1r3e5fJYjNXgodoSWn6tZWCXyBaLqcPwddZRx77XPJrRfE4mMorraIS4bYfA5w2ood6RB95m2oIJyqM8vQ5VldRKAwlIDb/DD88gMQG/rmC00CSI8u1u8jtMAALjCh1Hbb54jTw26UNuv/8Cy1jF5EHt5qDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757171655; c=relaxed/simple;
	bh=wmUfztRX5nD3fOdPlKxX4nL8xn68x2d6zm4zTl6Fhqs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BykEihbQpwShC/9jxm0uAkDaF6oauhQesVbQpeN4QKS7/3qIh7tYpLfoR5qKFnh/jGwNQHacVaNT4QM/gPJcZO1ocpFYOUTqdH/tqIXS6tHs3x9vvMmNCieIo4aeZbxo/UpZptlG82smbryZS3x4zE0TafUms6HLyO4GgId/USk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=DgQxAKLf; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1757171642;
	bh=wmUfztRX5nD3fOdPlKxX4nL8xn68x2d6zm4zTl6Fhqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DgQxAKLfFEUUmoaJIwrfJ7Jo59GnS2g905k4FbGOOM/aVw5wEi385JapxQ8bPYnKG
	 QytheVy+XXtwlUlPgwSS5uNyoUPRnOaBcSdRRDuZ908cbRIsUAEbMKmCrnUwsbz79O
	 Qls5ClGRZ3uWYVPG/Q43MfNXFQL3eCVGqGs6CNVM=
Received: from zm.. ([2408:8340:a2e:f9b0:20c:29ff:fe69:94c7])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 3809F0EF; Sat, 06 Sep 2025 23:14:00 +0800
X-QQ-mid: xmsmtpt1757171640tfgg6490c
Message-ID: <tencent_663B255BAD2BF224E8B5195BCF1F4A4BEC07@qq.com>
X-QQ-XMAILINFO: MwP4Bu21pARcKqVk3VrIPiTRO9UHcDi7G2232LhBM6+V319dkLRGggADrn5tBJ
	 Qk97gZ+Naa6p4hoXxLb8r++EL/ZHF27trB0ms5ivR/uvEJ1Cib1bhzjmTgt+WSEKHrI8U3l4cv7P
	 X/Jh3jQf7LlF2s2PkZQD6EtyPPm17LSUe6LaFd8Hu+o3yo+R4LxotQ/FZwXrmkG22gpn6AUqvzgh
	 PMYJEXqUmqhKcwE5Vq9JzPm2lLGarlvzQUyl0O8QOZiCI3KA4qSdqQ2oPPMJCT0CitwZLbKNU4VE
	 RTOn1K7SCcXvLDlhZwV14kWemAG0EZYrni9ee/0mXcH3CecGBAHXbEMR9Cf0BWZlWGUjlV/VqSdt
	 029EBDtU9JAHWxrizB+YQn4ASW7FP6xv+l3VBmA7E1U7HyzG0mJPnJi4xQtEBy8p4I9jXbsfjvwt
	 Z9Ls7bHcerlB3Zhbyw6yWUTZQkRtGsSVQfxH0gqRtoOrWMDN2bhgdQv8LGMNmUMAiISdfPImFvbc
	 NRr+wNUTd6DxIbX6J/3fAT98CXlK8r5keZ/V6IslfX5TCQhexkl0HCj2S2BMsyo4JHgc1zGkbZrF
	 mV+iSdQg/BVnkARnHBvPVj/perPuVrkOfVwO+Cwb255Xv48FL52U+GTMH68nK2f+QwTrK9iPmYxJ
	 M4OWf+tuKxvMgOeSLX6KzYRgzOcK1KcURkCu7tyVt25ciQ5izW3mY5a4iXOaXhHhIpsEvWvTtChj
	 T0b3Zqigwk9jPJJDLXLZNi1RecQnBH1kbuEOSE4tVixsXs++TLHRzg61YNGyKYnvqJbxNQXg8dlK
	 X6RfKgUz8j200dQMsJ9MPfm3G/Bx1mlvcbqGy/pknWc4O88Tee1jdRNM4odWTwojwspqwqVyKbD5
	 vlTRAi7jHMY/h0D95FUaBrEnq1tOYWdsxUAgnpMwyrcQik1F0x9+7hbnF6zAEDH3Zw7VuRqL9lL3
	 x5n2a+ykhnxumQ4D8HMHEEdaA0ZZzboxtBx0HU9LX6eRUA1EW1vpXzVlAnWHRQlt2B7vN2cHcBnL
	 BzREKhADSdahwmnN3SMQDMvrmNLHyHeEdIGUcfJt2seic8wnBzrVfM86JNeTVr4Gv1UA2bZkyw/9
	 quvC+dyXIC397rlk5qCfT+Tnz1sw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: zhoumin <teczm@foxmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	teczm@foxmail.com
Subject: Re: [RFC PATCH] vfat:avoid unnecessary check
Date: Sat,  6 Sep 2025 23:13:49 +0800
X-OQ-MSGID: <20250906151400.1913598-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87plc4n9e5.fsf@mail.parknet.co.jp>
References: <87plc4n9e5.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi Hirofumi

> Hm, IS_FREE() checks 0 and DELETED_FLAG, isn't it?

Yes, you're absolutely right. That was my mistake—sorry about that. Please
disregard that part.

> OK, thanks. I got the reason.

> However I would prefer to keep the current code, for readability and
> future changes, and explicitly check those time flags if there is no
> measurable improvement.

I understand your preference. That said, since fat_truncate_time already checks
the flags and handles them appropriately, I still feel the double-check might be
redundant. That said, I respect your decision and am okay with keeping it as is.


Thanks,

zhoumin


