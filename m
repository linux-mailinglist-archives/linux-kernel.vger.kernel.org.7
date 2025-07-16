Return-Path: <linux-kernel+bounces-733707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11257B07811
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F4E4A5F29
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC1A214232;
	Wed, 16 Jul 2025 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="pjtQlq8I"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E61A238C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676183; cv=none; b=ZG0co8XV07bMmWMIu+PIpk7tBTbNlESpK+mqtysaFLKvHKTQLk3Sa3Vm22Yf3UAFW65DI/itpom4KOfJe5VZadkh/4euykgX6fK/Z1RrvHlCGC7vDaYIZJwQUbPxTv5EsNGg8BD4P/BI1iHPmkz/g2gxxr0r137aaWJw6blKE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676183; c=relaxed/simple;
	bh=eKUmlpIGboQT6S5Ovz6KOSqf2T5cj+mftR73RhnZT+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAKxA7y9D2QDgvpE/3epiIYGj+HgCQU5V+sXM6TwLtm8MVzDg5VT6D3M3UE4QgW1u1z8wQPRzK5kIg9ScbRqAIwS4oEJRF284i5JkNBP3m7H9qcXXvsgSwPpxeWL3ryFvIPbNuU6smqPNdgc6WFinomgxYHeLib4kxuslhy5tC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=pjtQlq8I; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6facacf521eso56647216d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752676181; x=1753280981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt9z7TyyvFxzc9Zi5QX61Y9RbsiY23u8uaORF/jvc7k=;
        b=pjtQlq8IX8EaOxjjDRdPRgI92utzhFKWca+2epJjYzCqL0ml1OceuruNYv4YPrvlwj
         nr3BlrXUyZFovuHUUIKtEGWsfI0RF9Wm98suBLvLCYZ5X8UrVoemUel8DjqfVdl7GgUS
         qNN3mslKO70h9htLfkMcY+XP9lm4eJbtWoxPyjUPUzILHZF2Q42vRavSxYglC5pilLz/
         TYZgkAE2JqMee654L65PhAebhTI4+aNW1pw/stRveuurM3+JKc860CZ5wYxaegQfyvE1
         tcQkZDC0EgBxFGdcKGnZCLYEIXfSF1XDpsq+JBcGAX9jp1X/DtTAUTVGS9FOLjLGliN6
         Q2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676181; x=1753280981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt9z7TyyvFxzc9Zi5QX61Y9RbsiY23u8uaORF/jvc7k=;
        b=igK2XfukTbA4MwXdeuFiznV/Bg3gq312jgcZ23zHz+wzEys6gaJOzWbXRDlZ5oZJ7A
         6+mfPGpl9cgs5O/spjcw1l+r165CNelXZ0A2B996XEpvVID7L9zh9cTN2exXykl43GOX
         czX9LxrWJ94zyCm+ZX22Uf66QbWqspnBJ/iUNi/z22ZUd86Qfl0/eKf6J3nxEsuV9NOR
         HhfQSInikeX97ajyl9ufuEIBShUVEKVZlYZFwT9Yfr95niAvbcCixLHagwQcZ85h0z6X
         jhO7Lz/eh6iT/BoIgSuS8JKV5ptYAx2xKpxvWpwdw8sS1etkDtC6KDToGtrzluFFK4jU
         5f+w==
X-Forwarded-Encrypted: i=1; AJvYcCWoHId82lTfWG4jpYgsAMbnnfWjOefZD/JOwyrQd+vLfh1YI+XM3Xm/e1hTGJp2xZW9ia/+uQuk3lwabMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc3UFx5RmAD996RXbt7Tngm+8S0EA6iKaz0kpUTruGAhnfMREL
	+PZQye7kRip6MJvtEtw6sXdQdJVh+Fr44tC9b5E0Y1IP/jjjzxC5DlrVmq6WVomWQw==
X-Gm-Gg: ASbGnctcnDUggYSd96a5SSkIUdZoFqOb4xm/3yFutHxC7eQEw9WDr6c6RVPo07iuy4z
	7CrwObuG/NfrmGwjBFesc7SUq8Uv3xcEOtVdqtkYGgUy7gOBLONHm1YntTBlHrnZZH5xlQeJUGi
	99puqwVPIDYbfZNtO1bVVrT95lxEy4zm+uP/c8HnJfgJpBGvbXAealiDnzWl6AtccPlYjlxg+a7
	PhoYw81dffhfRiBGH3pX+Dw9qzoIzFDxBlZtznYUG/BlHqLFlmtOZ32etUoNbb+p6aLULTaXFIr
	6steNJG+DaWQOfM/BBIIw/5NKBIeX5Av0RcoSkDeQGXIK1u4CWBcBkXxafkYE0R5LIhWKdJZeY1
	i3JgSb1bGe+hLlMjGcY8N/AKA2VwiO7OrUSu+dfAq
X-Google-Smtp-Source: AGHT+IF3xlSqjICIE4by+UPGer4acYrJ4z0g+fjVRC6/rj7+8rf0BJhYUp+VmTOPflFKpHho7TjrBQ==
X-Received: by 2002:ad4:5cec:0:b0:704:7dbd:d991 with SMTP id 6a1803df08f44-704f4a9a406mr57966406d6.31.1752676180409;
        Wed, 16 Jul 2025 07:29:40 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39c9dsm70452096d6.66.2025.07.16.07.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:29:39 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:29:38 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com>
Cc: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton (2)
Message-ID: <78c3fb66-c30f-4c64-a499-61c1665186a8@rowland.harvard.edu>
References: <8bec1698-5008-428f-8e71-ec002def0c54@rowland.harvard.edu>
 <6876b0ec.a70a0220.693ce.0019.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6876b0ec.a70a0220.693ce.0019.GAE@google.com>

On Tue, Jul 15, 2025 at 12:50:04PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> UBSAN: shift-out-of-bounds in s32ton
> 
> microsoft 0003:045E:07DA.0001: ignoring exceeding usage max
> microsoft 0003:045E:07DA.0001: unsupported Resolution Multiplier 0
> hid: s32ton: n 0 val 0 size 0x0
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in drivers/hid/hid-core.c:69:16
> shift exponent 4294967295 is too large for 32-bit type '__s32' (aka 'int')

Benjamin:

Clearly there's going to be trouble when you try to convert a signed 
32-bit value to a 0-bit number!

My impression is that hid_parser_global() should reject Report Size or 
Report Count items with a value of 0.  Such fields would be meaningless 
in any case.  The routine checks for values that are too large, but not 
for values that are too small.

Does this look like the right approach?

Alan Stern

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git c2ca42f1

 drivers/hid/hid-core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: usb-devel/drivers/hid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/hid-core.c
+++ usb-devel/drivers/hid/hid-core.c
@@ -464,7 +464,8 @@ static int hid_parser_global(struct hid_
 
 	case HID_GLOBAL_ITEM_TAG_REPORT_SIZE:
 		parser->global.report_size = item_udata(item);
-		if (parser->global.report_size > 256) {
+		if (parser->global.report_size > 256 ||
+				parser->global.report_size == 0) {
 			hid_err(parser->device, "invalid report_size %d\n",
 					parser->global.report_size);
 			return -1;
@@ -473,7 +474,8 @@ static int hid_parser_global(struct hid_
 
 	case HID_GLOBAL_ITEM_TAG_REPORT_COUNT:
 		parser->global.report_count = item_udata(item);
-		if (parser->global.report_count > HID_MAX_USAGES) {
+		if (parser->global.report_count > HID_MAX_USAGES ||
+				parser->global.report_count == 0) {
 			hid_err(parser->device, "invalid report_count %d\n",
 					parser->global.report_count);
 			return -1;


