Return-Path: <linux-kernel+bounces-826490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833FCB8EA7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90269189A0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC4E15624D;
	Mon, 22 Sep 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8ZoIfv9"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337A148830
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503444; cv=none; b=m4v3lvMzNSdRMfHQFmUaO9F1ILZorlj+bqwnu6Y0IdoGKJUEJd++XEKT8Vxu+Iqit9m3VeWlKAqGT0jdfwXKG389jTUECMf0FN+Mzz/5MaRF714qWWerx4QFj+AdEqz2S3vZ/goOWHkifqBtNZ7MwxAwNYTvgBU6Y+njYifZSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503444; c=relaxed/simple;
	bh=M5wz9xqOwUfHtDVvMp9nzAi5BBDdS8BQxS9fvLMQ0nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgdCfI9JNbpzhovVfV0PE9qEEOkrfE3tuVyrWfAv61Pv4SQ6vBpwT9ADIAYwSb8yIcew2ZVMMxg885MUDCuVsgGzN/Yy3BeTaQ+Fw7XESFctWrNGT3cIedvWeHWf4tEgw5Jxp4VeWuI+u5RQrgoGOg6tTD6UEv4448C2h9V2Z2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8ZoIfv9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b2ac72dbf48so111290966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758503441; x=1759108241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MkJ7oUnUH/4XWT8grjBfyBKEOMi6atBFTqk4gqmuuc=;
        b=H8ZoIfv9DSR1/hp6JpXytlIGxWeyxbDOAgZ1ldhM7onVV0tw9ZOLtFyVaywrJxmn+j
         DDSO0l47Z9Qeoi8mnW2W8tJS0CDzx/NvkJVhlimIf6QKIIJ+++gy6ddVxb/s9NO0pzpQ
         ohzmZRk3iuXgw3lFYA7H+h1WxCaY5OLsfoBZL70HL44Q89ZHURlpvTdsndiUplxTVCho
         fAZyp7KXHYeyXPjrdAF1vn66OXoDvfbpVzF8dfzqdB2GHL+PlESDX9nsyW3SCBpSNIgT
         mc6XdOXDZ9DtNg9H3iTRCIgrA3VDrI7X1OGGvN8K5Dh5Y5kKrB47Wt3Bw++oZqh2fGcQ
         tCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758503441; x=1759108241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MkJ7oUnUH/4XWT8grjBfyBKEOMi6atBFTqk4gqmuuc=;
        b=r7xMSz/sKz9sJOYLiPXNFfLNx1Ijs1pSDAWIg0VUusU7MJMJXBS33yDrlOW2XcBuFF
         +uDHkAfV079OfluFrHP8Uup9IVGdF8F8Q8KxY+fC7h5YHfL9H5lkUSE2ba54o6xRDjD0
         0B9h9kD/KW9q09Oug58u6e6FtNOQHfV4vV7vTH2x+wOqSZxb2B/Jpou8ed18c0l0RtHP
         s5TdwihocHTFFg1XSeOvWFKiWKRn17CFB/TeObSgJLIxEZ1T1ln2diJdzFQd4wkmbZoZ
         KgJklly32ACIn9VLR998r+sF1fW82PgL8ndngR2nPV/mtuc1vS8/4I4UCda3Krtf1uSN
         lvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE3QzbpDlOy/6/0wq13YyVTyaSvAm8Dh6j7MxNAB65js/xtGUEbqjhODCr3SC7xjuBD9+6A797dJZuGr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVF3uOsBam6U6mVaQYs6viaiP65xXGf72bGOkETqSr+Gb4wUWt
	hT3ayj8/3PSrc64u+5Dy282BZ4vRwFJ1bdu4A3hK85R8rNhgw2sX0SyF
X-Gm-Gg: ASbGncvDZ4GcGGxP9JqlzJ7zbGJrEBgcSouWr3iENAiHokzn2ayDnFRp4S5UiGCNjCc
	R72Jgy/kwJjxlqGxy5OHzNI1bVw1pQGVReNluuUm8yii/MRN7vl0RLzAN2Kt86De22EoIxiMbT+
	AW2xeVl5Y0jP23yTD2hjtxhXqC9HVkgGyDwVepEPazp7WTJ5REZnoYVMPxImZMDoU9LT3opbHqM
	56+P/asZ5n928dJMBXshJJqzdL7e00ZuPERLvwZv4vdCoB3ezbpIJRtbdqHGYeWFsSvh61Jve33
	zhtzYbuotqjQnmMWCOOiPLhor91Kwovpqq3ihxAgBhyxmSR76NmzdGEGFkAmIa8Tc/ehDI9EJuD
	LjzBMoF/C7HJSHH6ZOx0=
X-Google-Smtp-Source: AGHT+IEvTen8ntQeNOQqNFT2eKUrH0+zq+HnLQQTKn/Su0UVk9XUetSFBmS6KjUaD9cJm9/WF53iGg==
X-Received: by 2002:a17:907:d0d:b0:b04:6546:345a with SMTP id a640c23a62f3a-b24f442d830mr1120956366b.52.1758503441503;
        Sun, 21 Sep 2025 18:10:41 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fcfe88bc3sm956702866b.51.2025.09.21.18.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 18:10:41 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	cyphar@cyphar.com,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 05/10] man/man2/fsmount.2: document "new" mount API
Date: Mon, 22 Sep 2025 04:10:34 +0300
Message-ID: <20250922011034.96618-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250921230824.92612-1-safinaskar@gmail.com>
References: <20250921230824.92612-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> MNT_DETACH, not MOUNT_DETACH

Same for open_tree and open_tree_attr

-- 
Askar Safin

