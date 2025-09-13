Return-Path: <linux-kernel+bounces-815088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85957B55F33
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48721C27CA1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81C2BDC15;
	Sat, 13 Sep 2025 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="JlzeG8Z7";
	dkim=pass (2048-bit key) header.d=onevista.com header.i=@onevista.com header.b="YJ/ich5Q"
Received: from a2i558.smtp2go.com (a2i558.smtp2go.com [103.47.206.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC826B95B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.47.206.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757751054; cv=none; b=Slz7ntjknZ5YUmc6vi1xAdXRjGlq0CSkdKgGWZI4JunmgVp/oh4uYVNYK/MkhLGbNGdOl8/5Fq4efAKFVlXBu7HBTzQW8TkLc/OI7KCBs2FrqzGDNX2KHO64qjcmvV+TkKm9mVl+x1dIKV6qvX87YrpBw93TIJADw/7z09wRi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757751054; c=relaxed/simple;
	bh=OxYBBGHD7PcEiS0+megl12rJZTW9RC9FZwgYntaOhIU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=YDNTydGNmXKjoy0l/ypjn1AfrdUtl74zfJO1wj1LENpc2FeQog3h7wmva/NgfRqtBtjQgsPOUn8nT9rSkAapLubDzc0iCbDfODOwkSrqShqCXvRlHl02QCDxYhT4jK21IxIfrmCK0yqB6I0+lM5FbO2FBgZ9KLBU7zz/eJfZHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onevista.com; spf=pass smtp.mailfrom=em674053.onevista.com; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=JlzeG8Z7; dkim=pass (2048-bit key) header.d=onevista.com header.i=@onevista.com header.b=YJ/ich5Q; arc=none smtp.client-ip=103.47.206.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onevista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em674053.onevista.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=meg3p3.a1-4.dyn; x=1757751950; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=pczBoT8r/1/zMh33v8Z6ki/8C7T+GtLQSkc57BzSm6o=; b=JlzeG8Z7oeTLd4TUfJTofJe1Bi
	dUWMI8PQJz3rPzW3DlqXtSkRrOvw5e1ZM4rOROaocD3PbRQJMBj/H2S+pJlQMhDvxtq7hAtUBcC9u
	ntSkrLWCH37Kgxn3ddexcCcu2GoAXM87cqIMS/iocSYJ6hA4m/TPy84ia9xwWr2pp2mMdmnUy9F0m
	XkfOofngsicyUmrMn7k3QcxYCa8xlwUtjmPEwMHO4gVdG1RmvchzZ4eFpxsz50qqqt060TN7JeXm0
	w9Oz3/3lpVkQbWMa5bTWr536PKAl3GCyRLhWNai1vShktI5PDLW579X9p7th8t15ANSsqk1wxnT/1
	3+VXFfGw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onevista.com; i=@onevista.com; 
 q=dns/txt; s=s674053; t=1757751050; h=from : subject : to : message-id 
 : date; bh=pczBoT8r/1/zMh33v8Z6ki/8C7T+GtLQSkc57BzSm6o=; 
 b=YJ/ich5Q2D2BswtbuMMcEg74ld69GE6NMXMtt0EKDq8pBFLr+ADkKe275N9qvR6pcp9Dbw
 wIUes1EgpUAHH+EcA5x4nq8hkJ5EmWaSF0VcXYI9MpJ/DwhYT3LSeEB9RN5XZ/Ai6bKcxnJi
 zMEdvgeL/qLWxY95zBDC6nP73eQPNSoec6SFeeymO8NAn9LeDfQ/SPvCUm5864W/9zoKTB21
 2Ek+wlfo5NcCuiljOghUYzkWIuWMWxbnWkKAVSTDIm6cdX160zQZG4mp+F79Iw1pHGR1W9rk
 FEv8raG1m8ZsKOrVERnXWntMuaQoTbgk8yJXQTNIX5jxblL7NYXH3m3Q==
Received: from [10.45.33.53] (helo=SmtpCorp)
 by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_SECP256R1__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <johna@onevista.com>)
 id 1uxLIe-ED4wXo-PY
 for linux-kernel@vger.kernel.org; Sat, 13 Sep 2025 08:08:00 +0000
Received: from [10.148.241.57] (helo=onevista.com)
 by smtpcorp.com with esmtp (Exim 4.98.1-S2G)
 (envelope-from <johna@onevista.com>) id 1uxLId-4o5NDgrsN09-fbSx
 for linux-kernel@vger.kernel.org; Sat, 13 Sep 2025 08:08:00 +0000
Received: from 10.89.250.5 (localhost [127.0.0.1]) by onevista.com
 (x.y.z/23.17.42) with SMTP id EAA13592 for <linux-kernel@vger.kernel.org>;
 Sat, 13 Sep 2025 04:07:58 -0400
Reply-To: johna@onevista.com
Date: Sat, 13 Sep 2025 04:08:01 -0400
From: John Adams <johna@onevista.com>
To: linux-kernel@vger.kernel.org
Subject: unsubscribe lkml
Message-ID: <20250913040801.7795efa4@onevista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Smtpcorp-Track: kMah-tIpH9d4.Mk--q0nmNRwF.GsbdjgEQEBp
Feedback-ID: 674053m:674053ak6XMwc:674053sVQm__qnV0
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

unsubscribe  linux-kernel

-- 
John Adams (johna@onevista.com)

