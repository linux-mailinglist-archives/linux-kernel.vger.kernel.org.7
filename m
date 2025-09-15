Return-Path: <linux-kernel+bounces-817340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E13B580FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC781892DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCF7214801;
	Mon, 15 Sep 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kb+pO4ya"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A536EADC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950288; cv=none; b=SgLEnhz10Rt8kMlHM5HKrnG9A4GH2+QXrizeQf9+bbSsdbJcwvXK44iGB+L0X8tOYjOmy+fF68GRLJfVhpnQuUnshCu7HtkRDSwf2zL1urxg+4mP9a030lCZTpeAnvkM6jNiC5xpirQ2F7MASE0m8FS2znMgv+EtzOTBja5ZBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950288; c=relaxed/simple;
	bh=rEvp9FHMMcl+tnWv6KGWVC/KMLIhdGJDy47CLEOkMgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7BSbUG/Xvyktu6oIGWVMYc8ExMtcNdXWBjG7tOmNrm3Im4F4as5G0lxthJTF6pAjfElnlpegSY+CvwH7bP0u1Ppt9L5HDFJxXyh50Kb3P0/6VcxItXKNCk8Uvp1Ig5/1WW8NRxzQGmOXn+5lImLY/s4RlpUnxtird0SF7UBXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kb+pO4ya; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757950285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijKjVgsGKrsgKBfC3v4CL8dPf1ojG5PTyoe+k0iOTMY=;
	b=Kb+pO4yaGX62D06Hi0gI9Sot0TaRO8LR8deYwIxwzLHrFDXRlg8/58bzXXWOVK2HyCHsRR
	2Hq1kUvmPDK9X1seN87tFhIlkPPzYxhCi781BJ36Qa1KnBh10+W9XnxZ3zY/PSPBlGqtxx
	Bep2TV8JSO1rSaEXb1fivshJSkK7osc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-5x_01ijGO5yKNtTdDCxtqg-1; Mon, 15 Sep 2025 11:31:23 -0400
X-MC-Unique: 5x_01ijGO5yKNtTdDCxtqg-1
X-Mimecast-MFC-AGG-ID: 5x_01ijGO5yKNtTdDCxtqg_1757950282
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b078ab1c992so523972066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950282; x=1758555082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijKjVgsGKrsgKBfC3v4CL8dPf1ojG5PTyoe+k0iOTMY=;
        b=ma1JOJ+xIwic0IY9Q7xnMyQUPcLD6/fq/uiR3+gN66hPOn4GI913z2UBRZpu0Vh87b
         EP7dZbcie8bTBATPHmDhQc6sK/4Zei9gUKXxJTDIfrDtWoqseQZIYfbldIizwPmBWl0t
         94tadDGDDwEDGAaeKdlj2HJhcAAe2+4uJaShEtun+aZ2ubjIUvnlMEFKBwx4RPGe+lyz
         1jXsBLgj9Go4ohkPXmjOaPEvS3kLU+gb0osFOjWfMY8YvPkkzZYgFX42J1OjY6RCklSD
         0b6F+eKvgMimqHjAoY7CV+TF9VlhfdVTTTQ5BNjyi1lYovQ06zp+675KF/rOnTES3xux
         z75Q==
X-Gm-Message-State: AOJu0YyHKl9ZR/YzSSOzjf0YVIMbvoMcL8sleR7M43jsG1QcBuYQ1VSG
	9tPWDMp77JfV49MZFYpmxXCoPwboc3hJUcTy6Z94UY41u7BzgGUonTNt6LZGomdvzD1tYyUTknr
	j0/ASScVErTXLkYtFKgFyv9ak6mg7GAHEcz6LQ0O/DNemk4q9bDmCmYGE11b6a2M8Mw==
X-Gm-Gg: ASbGncvPLvOKY9ievA9F2iKAkQPVw8/W5LIhBr8Ib3y3G2c4zqLHIKMX5kG/6evV2KJ
	ikuxZq+7BUHv8mlCNZ4nVtmw5VbSku9oYb6aO5NqGwcOU0BfcJg2xytZgQ4vfTOm7gq3zPupd4X
	HkNTO7SholkJJXYr2ojxFAhPFdpdILhux+xIe4WCvEIoW3PEjKYlTUmI3Fp/h4Zl6lZlOGYhtuc
	EIGdZ4G6qduRLEJr3nqOmqeq+c+dYnEDHvw/eZBWobgpcI3mSSrQP1rx2W/4D8uNub7sUO7fahu
	B0syXAQpe3QEh7tAYPR4D9F5++Jz
X-Received: by 2002:a17:907:7f90:b0:b07:885f:a54e with SMTP id a640c23a62f3a-b07c358281dmr1162944366b.23.1757950282121;
        Mon, 15 Sep 2025 08:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRXSeJUXREAtUBlKhyhYdRLPYRHXV5ewdR0Hl6LPR/OuzMIBY6cRHFcOXc1VipbuyucfuzHA==
X-Received: by 2002:a17:907:7f90:b0:b07:885f:a54e with SMTP id a640c23a62f3a-b07c358281dmr1162941266b.23.1757950281678;
        Mon, 15 Sep 2025 08:31:21 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31292aasm973924166b.44.2025.09.15.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:31:21 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:31:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] Revert "virtio_console: fix order of fields cols and
 rows"
Message-ID: <20250915113004-mutt-send-email-mst@kernel.org>
References: <601edd0a61e9a31d3d4f525a7c0648dbb4baa603.1757667309.git.mst@redhat.com>
 <6da404bc53aeb60f16cdfd1cc0bc70ee68a2ce0a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da404bc53aeb60f16cdfd1cc0bc70ee68a2ce0a.camel@gmail.com>

On Fri, Sep 12, 2025 at 04:06:37PM +0200, Filip Hejsek wrote:
> On Fri, 2025-09-12 at 04:56 -0400, Michael S. Tsirkin wrote:
> > when a previous version of this
> > patch series was being discussed here on this mailing list in 2020, it
> > was decided that QEMU should match the Linux implementation, and ideally,
> > the virtio spec should be changed.
> 
> This wording has been copied verbatim from a cover letter I posted to
> qemu-devel and doesn't make much sense for a Linux commit message.

Will change to "to the qemu-devel mailing list". Thanks for pointing
this out!


