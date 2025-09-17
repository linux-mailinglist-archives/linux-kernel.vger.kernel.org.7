Return-Path: <linux-kernel+bounces-821198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D23CB80B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0414872F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687803451AA;
	Wed, 17 Sep 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="VYoMMoAn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Di8Q9QLZ"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664B335927
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123625; cv=none; b=VW/IpGibhYHRAv9s6EpUoL19lwGp4Oq9TZ0fkyvGVp3hRUxvPCXrkl4Xqez3MY3K+YGAjtL756svZ/eYhrCsvhhKsEgq+AIfp+EvoHQ8fBtRF1EmbL+8Ua/1+xE+yfyeFLhf4O5T1UVQ9QFCaDA62GJ8vtKWEN1nrRHHbjcf77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123625; c=relaxed/simple;
	bh=VBUC016wQ+vYi7EWAPU70/RyeZxnrgF8QozZk01S2SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5TYF31c/lktPguOsHKJ/TGsH6iMMNkO9CCyHFVJGoqrmesjwop8aMUT/AvZtPjsfgcXmMnQ+FnK3fivTpjVmrAfXt8Uag7SrhqIWPvselhm2YfZHEfKwJPneV6A9Dtzm+7FsV7M1P0ySI4UnbbRONif7yxN+VBamKMCnxwxcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=VYoMMoAn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Di8Q9QLZ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E46777A020B;
	Wed, 17 Sep 2025 11:40:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 17 Sep 2025 11:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758123619; x=
	1758210019; bh=CAMFijMuE1/jMjlOYBJPpkWI2mxvY5nAqoCSx6+dKbI=; b=V
	YoMMoAnLUn/3eMDuQsowngdZ4YHPCJsl+bG1SUOktgVn3yaIawsITbOCMfS1Apdu
	MK+WJ7Wu64ykXuEFo8OjLRYLJFn+YSCgwnVU3SScdPQjGICMYDmAVgWB0I0THmcW
	2qNokz+ZJLH0TIIAzbrNrNVMMkKDpOjQbpGWHV3+dK3JM6xEbKN4SxTu5by1wF0w
	zevXmenLgbW8ktuHPeZngeOoNqLF8tIFVevKBKxNiM/tUWERQkxmHvpr6/taBhnT
	1yjj84ydJeCrhQ24F/TISjstb/UscXwDam2nGg2eIHzzvpNSnWfBY89z/ukVW0H9
	1wdGmN2bZ2OD8fSJfcvjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758123619; x=1758210019; bh=CAMFijMuE1/jMjlOYBJPpkWI2mxvY5nAqoC
	Sx6+dKbI=; b=Di8Q9QLZ2SBfCIBqkKMhGrLgdTarW+AEJhtHM0CpDiHY9/j13K/
	kSOPrZd5ikJGQqA9BGZYmjaeiTywh73SottOyl+E+FezwdWn88c9RxIylKlUDRCd
	91w456mWsE0ruBKCWpzahfPWH4KZ8pdsI/lzHu2XZK0xhzrS4jqZ+Yt3uHp91g72
	SM8AOprYyq0AA5dxy4F8jU5FugiTVC4r3F9G6fHjLeMqgyh0BK91QZDlyS8rGT8T
	Ey2sFgzPXSnWFMK+isAUYcxnSvxEvwNnYuj0M6MLvehWJZelzy5WY1/sHDP3NoWL
	WviPlBpqefeVdApI/e4+CvVtG4LBFJ6my6w==
X-ME-Sender: <xms:Y9bKaDEVomNB876-wDOpKf3YNYZs362HSJYnvV3BsZFMGDNFkOZ7OQ>
    <xme:Y9bKaHOHmnx1qddMB0ZjRATwAesWq0yFej-SfjuiVX1qrU8s5ZIcr1RDe_MDM8FtQ
    SmO2c1fT04fRRAfRhI>
X-ME-Received: <xmr:Y9bKaCF_EoYvKpPJ9hInnvNIap8ToClzYVEogZSDXGf2RQovQ8XVwz2_I-uoJaCZZbEN_omPEoKpWQ8glRK6-XMnaqXvTX8atog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhi
    ucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqe
    enucggtffrrghtthgvrhhnpeevieelhfdukeffheekffduudevvdefudelleefgeeileej
    heejuedvgefhteevvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepthhhohhrshhtvghnrdgslhhumheslhhinhhugidruggvvhdp
    rhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvg
    hfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Y9bKaOPQVvI98g_hscUlprSuEuhukjErCsdR8CRvLBF439i8K9FniA>
    <xmx:Y9bKaD-jFf3iPoYkox2lrqhvo1ba7x6GBDhqst1ytg8LOG32bIfQHA>
    <xmx:Y9bKaKQp38CNxG-PWrd4R3K-kH26h8OP2aZtczo3q_QMaf6WgiDfbA>
    <xmx:Y9bKaNkgvhKANpp3xf5RdQvvSAGwYNYJ51Fez5UWTP-n9c07xqcGTQ>
    <xmx:Y9bKaAKalNEhYF4XRqv4hQAnZjq72jfc8PXPJcaVaPwMKlq6EgUfzH6w>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 11:40:18 -0400 (EDT)
Date: Thu, 18 Sep 2025 00:40:15 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: use struct_size and flex_array_size in
 ioctl_add_descriptor
Message-ID: <20250917154015.GA67868@workstation.local>
Mail-Followup-To: Thorsten Blum <thorsten.blum@linux.dev>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250916122143.2459993-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916122143.2459993-3-thorsten.blum@linux.dev>

Hi,

On Tue, Sep 16, 2025 at 02:21:45PM +0200, Thorsten Blum wrote:
> Use struct_size() to determine the memory needed for a new 'struct
> descriptor_resource' and flex_array_size() to calculate the number of
> bytes to copy from userspace. This removes the hardcoded size (4 bytes)
> for the 'u32 data[]' entries.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/firewire/core-cdev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to for-next branch, since it works as long as I tested with the
following userspace appliaction:

```
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>

#include <sys/epoll.h>

#include <string.h>
#include <errno.h>

#include <linux/firewire-cdev.h>
#include <linux/firewire-constants.h>

// From include/linux/firewire.h
#define CSR_CONFIG_ROM		0x400
#define CSR_CONFIG_ROM_END	0x800

#define CSR_LEAF		0x80
#define CSR_DIRECTORY		0xc0

#define CSR_DESCRIPTOR		0x01
#define CSR_VENDOR		0x03
#define CSR_UNIT		0x11
#define CSR_SPECIFIER_ID	0x12
#define CSR_VERSION		0x13
#define CSR_MODEL		0x17

// See https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/commit/?id=d71e6a11737f
#define ROOT_VENDOR_ID_OLD	0xd00d1e
#define ROOT_VENDOR_ID		0x001f11
#define ROOT_MODEL_ID		0x023901

// Unit directory for AV/C protocol.
#define AM_UNIT_SPEC_1394TA	0x00a02d
#define AM_UNIT_VERSION_AVC	0x010001
#define AM_UNIT_MODEL_ID	0x023903

#define AM_UNIT_NAME_0		0x4c696e75	// Linu
#define AM_UNIT_NAME_1		0x7820414c	// x AL
#define AM_UNIT_NAME_2		0x53410000	// SA..

static int add_descriptor(int fd, uint32_t *handle_value)
{
	uint32_t directory[] = {
		0x00040000,		// Unit directory consists of below 4 quads
		(CSR_SPECIFIER_ID << 24) | AM_UNIT_SPEC_1394TA,
		(CSR_VERSION      << 24) | AM_UNIT_VERSION_AVC,
		(CSR_MODEL        << 24) | AM_UNIT_MODEL_ID,
		((CSR_LEAF | CSR_DESCRIPTOR) << 24) | 0x00000001, // Begin at next.
		0x00050000,		// Text leaf consists of below 5 quads.
		0x00000000,
		0x00000000,
		AM_UNIT_NAME_0,
		AM_UNIT_NAME_1,
		AM_UNIT_NAME_2,
	};
	struct fw_cdev_add_descriptor data = {
		.immediate = 0x0c0083c0,
        	.key = (CSR_DIRECTORY | CSR_UNIT) << 24,
		.data = (uint64_t)directory,
		.length = sizeof(directory) / sizeof(uint32_t),
	};

	if (ioctl(fd, FW_CDEV_IOC_ADD_DESCRIPTOR, &data)) {
		printf("ioctl(FW_CDEV_IOC_ADD_DESCRIPTOR): %s\n", strerror(errno));
		return -errno;
	}

	*handle_value = data.handle;

	return 0;
}

static void remove_descriptor(int fd, uint32_t handle_value)
{
	struct fw_cdev_remove_descriptor data = {
		.handle = handle_value,
	};

	if (ioctl(fd, FW_CDEV_IOC_REMOVE_DESCRIPTOR, &data))
		printf("ioctl(FW_CDEV_IOC_REMOVE_DESCRIPTOR): %s\n", strerror(errno));
}

static int retrieve_config_rom(int fd, uint32_t *content, uint32_t *length,
			       struct fw_cdev_event_bus_reset *bus_reset)
{
	struct fw_cdev_get_info info = {
		.version = 6,
		.rom_length = *length,
		.rom = (uint64_t)content,
		.bus_reset = (uint64_t)bus_reset,
	};

	memset(bus_reset, 0, sizeof(*bus_reset));

	if (ioctl(fd, FW_CDEV_IOC_GET_INFO, &info)) {
		printf("ioctl(FW_CDEV_IOC_GET_INFO): %s\n", strerror(errno));
		return -errno;
	}

	*length = info.rom_length;

	return 0;
}

static int wait_event(int epfd, int fd, union fw_cdev_event *event)
{
	struct epoll_event ep_event = {
		.events = EPOLLIN,
	};
	int nfds;
	ssize_t length;

	memset(event, 0, sizeof(*event));

	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ep_event) < 0) {
		printf("epoll_ctl(): %s\n", strerror(errno));
		return -errno;
	}

	nfds = epoll_wait(epfd, &ep_event, 1, 500);
	if (nfds < 0) {
		printf("epoll_wait(): %s\n", strerror(errno));
		return -errno;
	}

	if (nfds == 0) {
		printf("epoll_wait(): %s\n", strerror(ETIMEDOUT));
		return -ETIMEDOUT;
	}

	epoll_ctl(epfd, EPOLL_CTL_DEL, fd, NULL);

	length = read(fd, event, sizeof(*event));
	if (length < 0) {
		printf("read: %s\n", strerror(errno));
		return -errno;
	}

	return 0;
}

int main()
{
	struct {
		unsigned int generation;
		uint32_t content[CSR_CONFIG_ROM_END - CSR_CONFIG_ROM];
		uint32_t length;
	} images[3];
	int fd, epfd;
	uint32_t handle_value;
	union fw_cdev_event event;
	size_t maximum_quadlet_count;
	int i;
	int err;

	for (i = 0; i < sizeof(images) / sizeof(*images); ++i) {
		memset(images[i].content, 0, sizeof(images[i].content));
		images[i].length = sizeof(images[i].content);
	}

	epfd = epoll_create1(0);
	if (epfd < 0) {
		printf("epoll_create1(): %s\n", strerror(errno));
		return EXIT_FAILURE;
	}

	fd = open("/dev/fw0", O_RDONLY);
	if (fd < 0) {
		printf("open(): %s\n", strerror(errno));
		close(epfd);
		return EXIT_FAILURE;
	}

	//
	// Initial state.
	//
	err = retrieve_config_rom(fd, images[0].content, &images[0].length, &event.bus_reset);
	if (err < 0) {
		printf("Fail to retrieve config rom take 0\n");
		goto end;
	}
	images[0].generation = event.bus_reset.generation;

	//
	// Add descriptor.
	//
	err = add_descriptor(fd, &handle_value);
	if (err < 0)
		goto end;

	err = wait_event(epfd, fd, &event);
	if (err < 0)
		goto end;
	if (event.common.type != FW_CDEV_EVENT_BUS_RESET) {
		printf("Unexpected event type: %d\n", event.common.type);
		goto end;
	}

	err = retrieve_config_rom(fd, images[1].content, &images[1].length, &event.bus_reset);
	if (err < 0) {
		printf("Fail to retrieve config rom take 1\n");
		goto end;
	}
	images[1].generation = event.bus_reset.generation;

	// Requires delay for 2s after last reset per IEEE 1394 clause 8.2.1.
	sleep(2);

	//
	// Clean up the descriptor.
	//
	remove_descriptor(fd, handle_value);

	err = wait_event(epfd, fd, &event);
	if (err < 0)
		goto end;

	err = retrieve_config_rom(fd, images[2].content, &images[2].length, &event.bus_reset);
	if (err < 0) {
		printf("Fail to retrieve config rom take 2\n");
		goto end;
	}
	images[2].generation = event.bus_reset.generation;

	//
	// Check these contents.
	//
	maximum_quadlet_count = 0;
	for (i = 0; i < sizeof(images) / sizeof(*images); ++i) {
		size_t quadlet_count = images[i].length / sizeof(uint32_t);
		if (quadlet_count > maximum_quadlet_count)
			maximum_quadlet_count = quadlet_count;
	}

	printf("Gen ");
	for (i = 0; i < sizeof(images) / sizeof(*images); ++i) {
		printf("%11u", images[i].generation);
	}
	printf("\n");

	for (i = 0; i < maximum_quadlet_count; ++i) {
		int j;

		printf("[%2d] ", i);

		for (j = 0; j < sizeof(images) / sizeof(*images); ++j) {
			if (i < images[j].length / sizeof(uint32_t))
				printf("0x%08x ", images[j].content[i]);
			else
				printf("     -     ");
		}

		printf("\n");
	}
end:
	close(fd);
	close(epfd);

	return EXIT_SUCCESS;
}
```

```
$ gcc -Wall -o test test.c
$ sudo ./test
Gen           3          4          5
[ 0] 0x0404f693 0x0404a56d 0x0404516f
[ 1] 0x31333934 0x31333934 0x31333934
[ 2] 0xf000b243 0xf000b253 0xf000b263
[ 3] 0x08002851 0x08002851 0x08002851
[ 4] 0x0100014a 0x0100014a 0x0100014a
[ 5] 0x00051b70 0x0007eca5 0x00051b70
[ 6] 0x0c0083c0 0x0c0083c0 0x0c0083c0
[ 7] 0x03001f11 0x03001f11 0x03001f11
[ 8] 0x81000003 0x81000005 0x81000003
[ 9] 0x17023901 0x17023901 0x17023901
[10] 0x81000008 0x8100000a 0x81000008
[11] 0x00064cb7 0x0c0083c0 0x00064cb7
[12] 0x00000000 0xd100000c 0x00000000
[13] 0x00000000 0x00064cb7 0x00000000
[14] 0x4c696e75 0x00000000 0x4c696e75
[15] 0x78204669 0x00000000 0x78204669
[16] 0x72657769 0x4c696e75 0x72657769
[17] 0x72650000 0x78204669 0x72650000
[18] 0x0003ff1c 0x72657769 0x0003ff1c
[19] 0x00000000 0x72650000 0x00000000
[20] 0x00000000 0x0003ff1c 0x00000000
[21] 0x4a756a75 0x00000000 0x4a756a75
[22]      -     0x00000000      -
[23]      -     0x4a756a75      -
[24]      -     0x000466d5      -
[25]      -     0x1200a02d      -
[26]      -     0x13010001      -
[27]      -     0x17023903      -
[28]      -     0x81000001      -
[29]      -     0x00054009      -
[30]      -     0x00000000      -
[31]      -     0x00000000      -
[32]      -     0x4c696e75      -
[33]      -     0x7820414c      -
[34]      -     0x53410000      -
```

Thanks

Takashi Sakamoto

