Return-Path: <linux-kernel+bounces-862163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6075BF4918
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1F818C5B68
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4AF2571A0;
	Tue, 21 Oct 2025 04:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5yXQBfT"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80A256C76
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019404; cv=none; b=keyrKPYBuKOSGKgWUDwdr2cFb9ycrQOs02hoT/3lYuC2Rg3G8PWkCZk6MXnx5sujnsNo/VD7em6eZtkl8zA5TQjFc2JEY9WfHGsXvGFJ/6uYcuMFI3O+L6qkNejxRH7zzjZSJtB1IReM2W8heDaOXyUVnE0ldqAKbIxCrLQsodM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019404; c=relaxed/simple;
	bh=qkgQ+CuvMxhT7IF/OSj0mBr4K8PM/2u4lU3uq8Jys20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsas+1L22Xfkmdn1f6bsPRw8NhIZBJ0IJDTu5YXA//Tz6iDneNPsZDiaKesKA/Q7yxradDIZv9Lh4ML11Tmh2Ck6/qmj9NLBs5jUcaUjE9ZEPdT6+UJFF4VGuiiNRtB4VZOAVmQKADcAlbPBnR1uRb02slGSwv7Y6Vatk3xMAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5yXQBfT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so962726566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761019401; x=1761624201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnTDz5myCum0dz0iQoApan5kQSf5oDLmv5hHI45kMmc=;
        b=H5yXQBfTn7ILDfKZmkrNueqc3hPLA+lG952E3yIWJ9ApDYj2iGy+Of43mYcWQQsfMX
         K2B/YQLCY8r0BVD5loCLdZe/8yMToSPP7OY8zMt36PY0D9oeegSN5eEiTaNM9rNL5vZM
         4CSrloMgtSE9xNwzIIrwLc5wihRe3IeWKnaTCa2MeyTnE0ywH1QRAUUZa4JnLu2dJRkb
         U5tInK+ykDE8i8x3HniC154/XMQl0xbqI+lEXAVqJvwRYZLZiHbJ/Td7WQ17oIZ5kXwl
         bVSOEOa5nVh/+T4E1zUbHO6htfEZRYC7dhUTYPNMqKJqo4lg+pwmc3/1GiSV8HcTzY6H
         U5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761019401; x=1761624201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnTDz5myCum0dz0iQoApan5kQSf5oDLmv5hHI45kMmc=;
        b=tnZfwIi+Ki62uuJT4uYdjlzCxJoUIFbmSGcsUAesBIKLsP0s2mIlwAXk3FBd8csKCB
         jB8TtxYn1D1Es8PbCH5rGCrbTpB8kN6OyltMU726jYtVshxqo3D3Kg+3DRtsuWkfJNDa
         PY8O1Vr9HNXZqzsPMSrDp0FdWhRyMNSOFJ0ZB6qIHpx9xbaezf9Nz/WONcuptjb6DZ2p
         hld2MnIBNRYUY3vm1gfE6KhxbfA8Ix2wnkJUI7mnTa99JiTr+doi6+aUmK8BsfsCZCfq
         9wLAFkYRKybHNcexlVVZQS+/1uqj7NvpvACOipPE59CbEwTEc2LOcl3VdFV26aGo3Xq/
         3BKg==
X-Gm-Message-State: AOJu0YykngYBFseOcTYi3BYdb+HnPIU8lAOG5vUruRb3cFOedE4FetYz
	gmQ+DUocrwFd3eJ/enKzHpBf3bsdbJrOUOf/OnW9Lq+dOk14z1YmdC4srPOuYeTs
X-Gm-Gg: ASbGncsOqLAeTUsO5m1fGX2xsx7GbJMgzTdaAOW/HZGvkfhDN4zbmZAGPtNsw7hF1qu
	BbtG2NxpivgCX9x32HrFzOK+H+O9nYPvyO57SV28AXUQxPhETB5OQ+V9XESTPZevE519X5y8fJN
	Bse+IEaUE8Pj6D1aHN1e6ooowMOCDmlSMvaA8owZCKeRi0g1H/KzqUUNS0KhixcGF14s9IY4DZh
	oUU7g5lp43YOxXoz1OzwlRwLYlH21TouA+5KX2VzH7E4aSJHRcAAfZmbCn+BgNpCl05gMGbsgDx
	0BH+JG1SePY+sk8HADzh1YUlHG+Ui0OGZizyc3CJqI7HRxkpGnBr7SlWxWvYqC4GLRzO7q+Io5V
	6Lf3CATz/9ti5pr6IhOFkIBSWpun7pCTqoPDzLNeEQG9UgU3EgvZszMuTF6xQmY7Z0QO9qAe9mm
	iS
X-Google-Smtp-Source: AGHT+IF/W/OUyMQtEPCa5HqocBu5oNtQhxuKiUfejPDq9YCHbvzs4GnzMxPIwpn+wdtN2EqB3qg0zA==
X-Received: by 2002:a17:906:7308:b0:b3f:f6d:1d90 with SMTP id a640c23a62f3a-b647403a550mr1958365466b.11.1761019400841;
        Mon, 20 Oct 2025 21:03:20 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b65e7da3412sm961510466b.3.2025.10.20.21.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 21:03:20 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org,
	rusindanilo@gmail.com
Subject: Re: [PATCH 0/1] x86/power: Enhanced hibernation support with integrity checking
Date: Tue, 21 Oct 2025 07:03:11 +0300
Message-ID: <20251021040311.15214-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aE/gS7r1mrllLSSp@duo.ucw.cz>
References: <aE/gS7r1mrllLSSp@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pavel Machek <pavel@ucw.cz>:
> There's uswsusp support. You can use that to provide robust
> signatures. You can even use RSA to encrypt the image but only require
> password during resume.

So uswsusp project is still alive? Where is userspace programs for using it?

-- 
Askar Safin

